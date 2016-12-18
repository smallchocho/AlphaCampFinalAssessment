//
//  photoDataBase.swift
//  Question5
//
//  Created by Justin Huang on 2016/12/12.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoDataBase2: Object {
    dynamic var id = ""
    dynamic var photoLabel = ""
    dynamic var photoImageUrl = ""
    override static func primaryKey() -> String? {
        return "id"
    }
    override static func indexedProperties() -> [String] {
        return ["photoLabel"]
    }
}
class PhotoDataBase2List:Object{
    dynamic var id = ""
    let photoDataList = List<PhotoDataBase2>()
    override static func primaryKey() -> String? {
        return "id"
    }
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
}

