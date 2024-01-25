//
//  File.swift
//  
//
//  Created by Farid Firda Utama on 20/01/24.
//

import Combine

public protocol Repository {

  associatedtype Request
  associatedtype Response

  func execute(request: Request?) -> AnyPublisher<Response, Error>
}
