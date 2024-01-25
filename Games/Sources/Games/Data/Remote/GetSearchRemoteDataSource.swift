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

public struct GetSearchRemoteDataSource: DataSource {

  public typealias Request = String
  public typealias Response = [GameResponse]

  private let _endpoint: String
  public init(endpoint: String) {
    _endpoint = endpoint
  }

  public func execute(request: String?) -> AnyPublisher<[GameResponse], Error> {
    return Future<[GameResponse], Error> { completion in
      guard let request = request else { return completion(.failure(URLError.invalidResponse)) }
      if let url = URL(string: _endpoint + request) {
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
