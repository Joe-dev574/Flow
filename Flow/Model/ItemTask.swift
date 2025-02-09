//
//  TaskModel.swift
//  Flow
//
//  Created by Joseph DeWeese on 2/4/25.
//

import Foundation
import SwiftData

@Model
class ItemTask {
    var taskName: String = ""
    var taskRemark: String?
    var isCompleted: Bool = false
    var taskDate: Date?
    var taskTime: Date?
    
    var item: Item?
    
    init(taskName: String, taskRemark: String? = nil, isCompleted: Bool = false, taskDate: Date? = nil, taskTime: Date? = nil, list: Item? = nil) {
        self.taskName = taskName
        self.taskRemark = taskRemark
        self.isCompleted = isCompleted
        self.taskDate = taskDate
        self.taskTime = taskTime
        self.item = item
    }
    
}
