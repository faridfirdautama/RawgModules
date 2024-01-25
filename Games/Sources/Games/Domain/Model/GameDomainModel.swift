//
//  File.swift
//  
//
//  Created by Farid Firda Utama on 21/01/24.
//

import Foundation

public struct GameDomainModel: Equatable, Identifiable {
  public let id: Int
  public let title: String
  public let image: String
  public let releasedDate: String
  public let rating: Double
  public let backgroundImage: String
  public let descriptions: String
  public var isFavorite: Bool = false
  
  public init(id: Int, title: String, image: String, releasedDate: String, rating: Double, backgroundImage: String, descriptions: String, isFavorite: Bool) {
    self.id = id
    self.title = title
    self.image = image
    self.releasedDate = releasedDate
    self.rating = rating
    self.backgroundImage = backgroundImage
    self.descriptions = descriptions
    self.isFavorite = isFavorite
  }
}
