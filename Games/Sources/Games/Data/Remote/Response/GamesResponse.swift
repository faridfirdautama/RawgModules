//
//  File.swift
//  
//
//  Created by Farid Firda Utama on 20/01/24.
//

import Foundation

public struct GamesResponse: Decodable {
  let results: [GameResponse]
}

public struct GameResponse: Decodable {

  let id: Int
  let title: String
  let image: String
  let releasedDate: String
  let rating: Double

  private enum CodingKeys: String, CodingKey {
    case id, rating
    case image = "background_image"
    case releasedDate = "released"
    case title = "name"
  }
}
