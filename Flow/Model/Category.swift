//
//  Category.swift
//  Flow
//
//  Created by Joseph DeWeese on 1/31/25.
//

import SwiftUI

enum Category: String, CaseIterable {
    case today  = "Today"
    case upcoming = "Upcoming"
    case complete = "Complete"
    case events = "Events"
    
    var color: Color {
        switch self {
        case .today: .darkBlue
        case .upcoming: .launchAccent
        case .complete: .green
       case .events: Color.primary
        }
    }
    
    var symbolImage: String {
        switch self {
        case .today: "alarm"
        case .upcoming: "calendar"
        case .complete: "calendar.badge.checkmark"
        case .events: "repeat"
        }
    }
}
