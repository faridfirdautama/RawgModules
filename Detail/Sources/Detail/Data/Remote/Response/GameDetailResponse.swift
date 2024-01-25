import Foundation

public struct GameDetailResponse: Decodable {
  public let id: Int
  public let title: String
  public let image: String
  public let releasedDate: String
  public let rating: Double
  public let backgroundImage: String?
  public let description: String?

  enum CodingKeys: String, CodingKey {
    case id, rating, description
    case title = "name"
    case releasedDate = "released"
    case image = "background_image"
    case backgroundImage = "background_image_additional"
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.rating = try container.decode(Double.self, forKey: .rating)
    self.title = try container.decode(String.self, forKey: .title)
    self.image = try container.decode(String.self, forKey: .image)
    self.backgroundImage = try container.decode(String.self, forKey: .backgroundImage)
    self.releasedDate = try container.decode(String.self, forKey: .releasedDate)

    let desc = try container.decode(String.self, forKey: .description)
    self.description = desc.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
  }
}

