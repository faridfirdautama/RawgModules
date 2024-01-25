import Core
import Games
import Detail

public struct FavoriteTransformer: Mapper {
  
  public typealias Request = Int
  public typealias Response = GameDetailResponse
  public typealias Entity = GameModuleEntity
  public typealias Domain = GameDomainModel
  public init() {}
  
  public func transformResponseToEntity(request: Int?, response: GameDetailResponse) -> GameModuleEntity {
    let newFav = GameModuleEntity()
    newFav.id = response.id
    newFav.title = response.title
    newFav.image = response.image
    newFav.releasedDate = response.releasedDate ?? ""
    newFav.rating = response.rating ?? 0.0
    newFav.backgroundImage = response.backgroundImage ?? ""
    newFav.descriptions = response.description ?? ""
    return newFav
  }
  
  public func transformEntityToDomain(entity: GameModuleEntity) -> GameDomainModel {
    return GameDomainModel(
      id: entity.id,
      title: entity.title,
      image: entity.image,
      releasedDate: entity.releasedDate,
      rating: entity.rating,
      backgroundImage: entity.backgroundImage,
      descriptions: entity.descriptions,
      isFavorite: entity.isFavorite
    )
  }
}

