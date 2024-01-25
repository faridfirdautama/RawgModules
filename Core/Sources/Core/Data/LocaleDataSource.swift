//
//  File.swift
//  
//
//  Created by Farid Firda Utama on 20/01/24.
//

import Combine

public protocol LocaleDataSource {

  associatedtype Request
  associatedtype Response

  func list(request: Request?) -> AnyPublisher<[Response], Error>
  func add(entities: [Response]) -> AnyPublisher<Bool, Error>
  func get(id: Int) -> AnyPublisher<Response, Error>
  func update(id: Int, entity: Response) -> AnyPublisher<Bool, Error>
}
