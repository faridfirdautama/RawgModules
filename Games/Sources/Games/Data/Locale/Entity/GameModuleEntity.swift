//
//  File.swift
//  
//
//  Created by Farid Firda Utama on 20/01/24.
//

import Foundation
import RealmSwift

public class GameModuleEntity: Object {
  
  @objc public dynamic var id: Int = 0
  @objc public dynamic var title: String = ""
  @objc public dynamic var image: String = ""
  @objc public dynamic var releasedDate: String = ""
  @objc public dynamic var rating: Double = 0.0
  @objc public dynamic var backgroundImage: String = ""
  @objc public dynamic var descriptions: String = ""
  @objc public dynamic var isFavorite: Bool = false
  
  public override class func primaryKey() -> String? {
    return "id"
  }
}
