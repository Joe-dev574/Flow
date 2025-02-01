//
//  Item.swift
//  Flow
//
//  Created by Joseph DeWeese on 1/31/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
