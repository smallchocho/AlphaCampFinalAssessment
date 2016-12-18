//
//  SpeciesModel.swift
//  Question5
//
//  Created by Justin Huang on 2016/12/11.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
class Task: Object {
    dynamic var name = ""
    dynamic var createdAt = Date()
    dynamic var notes = ""
    dynamic var isCompleted = false
}

class TaskList:Object{
    dynamic var name = ""
    dynamic var createdAt = Date()
    let tasks = List<Task>()
}
class yaya:UIViewController{
    let wish = Task(value: ["name":"Learning","notes":"Realm"])
    let wish2 = Task(value: ["nam1e":"Learning2","notes":"Realm2"])
    let taskListA = TaskList()
    override func viewDidLoad() {
        taskListA.tasks.append(objectsIn: [wish,wish2])
        uiRealm.add(taskListA, update: true)
    }
}
