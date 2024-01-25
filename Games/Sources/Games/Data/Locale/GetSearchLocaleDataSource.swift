//
//  File.swift
//
//
//  Created by Farid Firda Utama on 20/01/24.
//

import Foundation
import Core
import Combine
import RealmSwift

public struct GetSearchLocaleDataSource: LocaleDataSource {
  
  public typealias Request = String
  public typealias Response = GameModuleEntity
  
  private let _realm: Realm
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func list(request: String?) -> AnyPublisher<[GameModuleEntity], Error> {
    return Future<[GameModuleEntity], Error> { completion in
      let games: Results<GameModuleEntity> = {
        _realm.objects(GameModuleEntity.self)
          .sorted(byKeyPath: "title", ascending: true)
          .filter("title contains[c] %@", request ?? "")
      }()
      completion(.success(games.toArray(ofType: GameModuleEntity.self)))
    }.eraseToAnyPublisher()
  }
  
  public func add(entities: [GameModuleEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          for game in entities {
            if let gameModuleEntity = _realm.object(ofType: GameModuleEntity.self, forPrimaryKey: game.id) {
              if gameModuleEntity.title == game.title {
                game.isFavorite = gameModuleEntity.isFavorite
                _realm.add(game, update: .all)
              } else {
                _realm.add(game)
              }
            } else {
              _realm.add(game)
            }
          }
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }

  public func get(id: Int) -> AnyPublisher<GameModuleEntity, Error> {
    fatalError()
  }

  public func update(id: Int, entity: GameModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
}
