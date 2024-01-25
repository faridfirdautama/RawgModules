//
//  File.swift
//
//
//  Created by Farid Firda Utama on 21/01/24.
//

import Core

public struct GameTransformer: Mapper {
  
  public typealias Request = String
  public typealias Response = [GameResponse]
  public typealias Entity = [GameModuleEntity]
  public typealias Domain = [GameDomainModel]
  public init() {}
  
  public func transformResponseToEntity(request: String?, response: [GameResponse]) -> [GameModuleEntity] {
    return response.map { result in
      let newGame = GameModuleEntity()
      newGame.id = result.id ?? 0
      newGame.title = result.title ?? "Unknow"
      newGame.image = result.image ?? "Unknow"
      newGame.releasedDate = result.releasedDate ?? "Unknow"
      newGame.rating = result.rating ?? 0.0
      return newGame
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
        descriptions: result.description,
        isFavorite: result.isFavorite
      )
    }
  }
}
