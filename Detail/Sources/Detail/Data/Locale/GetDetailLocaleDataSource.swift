import Foundation
import Core
import Games
import Combine
import RealmSwift

public struct GetDetailLocaleDataSource: LocaleDataSource {
  
  public typealias Request = Any
  public typealias Response = GameModuleEntity
  
  private let _realm: Realm
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func list(request: Any?) -> AnyPublisher<[GameModuleEntity], Error> {
    fatalError()
  }
  
  public func add(entities: [GameModuleEntity]) -> AnyPublisher<Bool, Error> {
    fatalError()
  }

  public func get(id: Int) -> AnyPublisher<GameModuleEntity, Error> {
    return Future<GameModuleEntity, Error> { completion in
      let details: Results<GameModuleEntity> = {
        _realm.objects(GameModuleEntity.self)
          .sorted(byKeyPath: "title", ascending: true)
          .filter("id == \(id)")
      }()
      guard let detail = details.first else {
        completion(.failure(DatabaseError.requestFailed))
        return
      }
      completion(.success(detail))
    }.eraseToAnyPublisher()
  }

  public func update(id: Int, entity: GameModuleEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let gameModuleEntity = {
        _realm.objects(GameModuleEntity.self)
          .filter("id == \(id)")
      }().first {
        do {
          try _realm.write {
            gameModuleEntity.setValue(entity.descriptions, forKey: "descriptions")
            gameModuleEntity.setValue(entity.backgroundImage, forKey: "backgroundImage")
            gameModuleEntity.setValue(entity.isFavorite, forKey: "isFavorite")
          }
          completion(.success(true))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))        
      }
    }.eraseToAnyPublisher()
  }
}
