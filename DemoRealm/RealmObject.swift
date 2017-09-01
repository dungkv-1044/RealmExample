//
//  RealmObject.swift
//  DemoRealm
//
//  Created by Khuat Van Dung on 8/31/17.
//  Copyright © 2017 Khuat Van Dung. All rights reserved.
//

import Foundation
import RealmSwift

class Human: Object {
    dynamic var id = UUID().uuidString
    dynamic var name = ""
    dynamic var age = 0
    dynamic var address = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}
