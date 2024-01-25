//
//  File.swift
//  
//
//  Created by Farid Firda Utama on 20/01/24.
//

import Foundation

public protocol Mapper {

  associatedtype Request
  associatedtype Response
  associatedtype Entity
  associatedtype Domain

  func transformResponseToEntity(request: Request?, response: Response) -> Entity
  func transformEntityToDomain(entity: Entity) -> Domain
}
