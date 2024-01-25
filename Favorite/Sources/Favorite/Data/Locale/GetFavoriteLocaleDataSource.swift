import Foundation
import Core
import Games
import Combine
import RealmSwift

public struct GetFavoriteLocaleDataSource: LocaleDataSource {
  
  public typealias Request = Int
  public typealias Response = GameModuleEntity
  
  private let _realm: Realm
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func list(request: Request?) -> AnyPublisher<[GameModuleEntity], Error> {
    return Future<[GameModuleEntity], Error> { completion in
      let favorite = {
        _realm.objects(GameModuleEntity.self)
          .sorted(byKeyPath: "title", ascending: true)
          .filter("isFavorite == \(true)")
      }()
      completion(.success(favorite.toArray(ofType: GameModuleEntity.self)))
    }.eraseToAnyPublisher()
  }
  
  public func add(entities: [GameModuleEntity]) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func get(id: Int) -> AnyPublisher<GameModuleEntity, Error> {
    return Future<GameModuleEntity, Error> { completion in
      if let favorite = {
        _realm.objects(GameModuleEntity.self)
          .filter("id == \(id)")
      }().first {
        do {
          try _realm.write {
            favorite.setValue(!favorite.isFavorite, forKey: "isFavorite")
          }
          completion(.success(favorite))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func update(id: Int, entity: GameModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
}

