import Core
import Games

public struct FavoriteListTransformer: Mapper {
  
  public typealias Request = Int
  public typealias Response = [GameResponse]
  public typealias Entity = [GameModuleEntity]
  public typealias Domain = [GameDomainModel]
  public init() {}
  
  public func transformResponseToEntity(request: Int?, response: [GameResponse]) -> [GameModuleEntity] {
    return response.map { result in
      return GameModuleEntity.init()
    }
  }
  
  public func transformEntityToDomain(entity: [GameModuleEntity]) -> [GameDomainModel] {
    return entity.map { result in
      return GameDomainModel(
        id: result.id,
        title: result.title,
        image: result.image,
        releasedDate: result.releasedDate,
        rating: result.rating,
        backgroundImage: result.backgroundImage,
        descriptions: result.descriptions,
        isFavorite: result.isFavorite
      )
    }
  }
}


