//
//  CategoryFilterView.swift
//  Flow
//
//  Created by Joseph DeWeese on 1/31/25.
//

import SwiftUI
import SwiftData

/// Custom View
struct CategoryFilterView<Content: View>: View {
    var content: ([Item]) -> Content
    
    @Query(animation: .snappy) private var items: [Item]
    init(category: Category?, searchText: String, @ViewBuilder content: @escaping ([Item]) -> Content) {
        /// Custom Predicate
        let rawValue = category?.rawValue ?? ""
        let predicate = #Predicate<Item> { item in
            return (item.title.localizedStandardContains(searchText) || item.remarks.localizedStandardContains(searchText)) && (rawValue.isEmpty ? true : item.category == rawValue)
        }
        
        _items = Query(filter: predicate, sort: [
            SortDescriptor(\Item.dateAdded, order: .reverse)
        ], animation: .snappy)
        
        self.content = content
    }
    
    init(startDate: Date, endDate: Date, @ViewBuilder content: @escaping ([Item]) -> Content) {
        /// Custom Predicate
        let predicate = #Predicate<Item> { item in
            return item.dateAdded >= startDate && item.dateAdded <= endDate
        }
        
        _items = Query(filter: predicate, sort: [
            SortDescriptor(\Item.dateAdded, order: .reverse)
        ], animation: .snappy)
        
        self.content = content
    }
    
    /// Optional For Your Customized Usage
    init(startDate: Date, endDate: Date, category: Category?, @ViewBuilder content: @escaping ([Item]) -> Content) {
        /// Custom Predicate
        let rawValue = category?.rawValue ?? ""
        let predicate = #Predicate<Item> { item in
            return item.dateAdded >= startDate && item.dateAdded <= endDate && (rawValue.isEmpty ? true : item.category == rawValue)
        }
        
        _items = Query(filter: predicate, sort: [
            SortDescriptor(\Item.dateAdded, order: .reverse)
        ], animation: .snappy)
        
        self.content = content
    }
    
    
    var body: some View {
        content(items)
    }
}
