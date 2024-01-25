import Foundation
import Core
import Alamofire
import Combine

public struct GetDetailRemoteDataSource: DataSource {

  public typealias Request = Int
  public typealias Response = GameDetailResponse

  private let _endpoint: String
  public init(endpoint: String) {
    _endpoint = endpoint
  }

  public func execute(request: Request?) -> AnyPublisher<GameDetailResponse, Error> {
    return Future<GameDetailResponse, Error> { completion in
      if let url = URL(string: _endpoint) {
        AF.request(url)
          .validate()
          .responseDecodable(of: GameDetailResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
