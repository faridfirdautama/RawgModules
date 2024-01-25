//
//  File.swift
//  
//
//  Created by Farid Firda Utama on 20/01/24.
//

import Foundation
import Core
import Alamofire
import Combine

public struct GetGamesRemoteDataSource: DataSource {

  public typealias Request = Any
  public typealias Response = [GameResponse]

  private let _endpoint: String
  public init(endpoint: String) {
    _endpoint = endpoint
  }

  public func execute(request: Any?) -> AnyPublisher<[GameResponse], Error> {
    return Future<[GameResponse], Error> { completion in
      if let url = URL(string: _endpoint) {
        AF.request(url)
          .validate()
          .responseDecodable(of: GamesResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value.results))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
