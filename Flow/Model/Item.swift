//
//  Item.swift
//  Flow
//
//  Created by Joseph DeWeese on 1/31/25.
//

import SwiftUI
import SwiftData

@Model
final class Item {
    /// Properties
    var title: String
    var remarks: String
    var dateAdded: Date
    var dateDue: Date = Date.distantFuture
    var dateCompleted: Date = Date.distantPast
    var category: String
    var status: Status.RawValue = Status.Hold.rawValue
    var tintColor: String
       @Relationship(deleteRule: .cascade)
    var notes: [Note]?
       @Relationship(inverse: \Tag.items)
        var tags: [Tag]?
    //
    init(
        title: String = "",
        remarks: String = "",
        dateAdded: Date = Date.now,
        dateDue: Date = Date.distantFuture,
        dateCompleted: Date = Date.distantPast,
        category: Category,
        status: Status = .Hold,
        tintColor: TintColor,
        tags: [Tag]? = nil
    ) {
        self.title = title
        self.remarks = remarks
        self.dateAdded = dateAdded
        self.dateDue = dateDue
        self.dateCompleted = dateCompleted
        self.category = category.rawValue
        self.status = status.rawValue
        self.tintColor = tintColor.color
        self.tags = tags
    }
    var icon: Image {
        switch Status(rawValue: status)! {
        case .Hold:
            Image(systemName: "checkmark.diamond.fill")
        case .Active:
            Image(systemName: "item.fill")
        case .Completed:
            Image(systemName: "books.vertical.fill")
        }
    }
    /// Extracting Color Value from tintColor String
    @Transient
    var color: Color {
        return tints.first(where: { $0.color == tintColor })?.value ?? Constants.shared.tintColor
    }
    @Transient
    var tint: TintColor? {
        return tints.first(where: { $0.color == tintColor })
    }
    @Transient
    var rawCategory: Category? {
        return Category.allCases.first(where: { category == $0.rawValue })
    }
}
    enum Status: Int, Codable, Identifiable, CaseIterable {
        case Hold, Active, Completed
        var id: Self {
            self
        }
        var descr: LocalizedStringResource {
            switch self {
            case .Hold:
                "On Shelf"
            case .Active:
                "Active"
            case .Completed:
                "Completed"
            }
        }
    }

