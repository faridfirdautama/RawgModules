import Core
import Games

public struct DetailTransformer: Mapper {
  
  public typealias Request = Int
  public typealias Response = GameDetailResponse
  public typealias Entity = GameModuleEntity
  public typealias Domain = GameDomainModel
  public init() {}
  
  public func transformResponseToEntity(request: Int?, response: GameDetailResponse) -> GameModuleEntity {
    let newDetail = GameModuleEntity()
    newDetail.id = response.id
    newDetail.title = response.title
    newDetail.image = response.image
    newDetail.releasedDate = response.releasedDate ?? ""
    newDetail.rating = response.rating ?? 0.0
    newDetail.backgroundImage = response.backgroundImage ?? ""
    newDetail.descriptions = response.description ?? ""
    return newDetail
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
