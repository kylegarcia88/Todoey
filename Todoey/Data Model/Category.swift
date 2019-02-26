//
//  Category.swift
//  Todoey
//
//  Created by Kyle Garcia on 2/25/19.
//  Copyright © 2019 Kyle Garcia. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    @objc dynamic var dateCreated : Date = Date()
    let items = List<Item>()
    
    
}
