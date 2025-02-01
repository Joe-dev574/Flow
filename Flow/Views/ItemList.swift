//
//  ItemList.swift
//  Flow
//
//  Created by Joseph DeWeese on 1/31/25.
//

import SwiftUI


struct ItemList: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showAddItemSheet: Bool = false
    @State private var selectedItem: Item?
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var filter = ""
    @State private var activeTab: Category = .today
    @State private var selectedCategory: Category = .today
    @State private var searchText: String = ""
    @State private var isSearchActive: Bool = false
    var body: some View {
        /// YOUR OTHER VIEW HERE
        LazyVStack(alignment: .leading) {
           
            CategoryFilterView(startDate: startDate, endDate:endDate, category: selectedCategory) { items in
                ForEach(items) { item in
                    ItemCardView()
                        .onTapGesture {
                            selectedItem = item
                        }
                }
            }
            .animation(.smooth, value: selectedCategory)
        }
        .navigationDestination(item: $selectedItem) { item in
            ItemEditView()
        }
    }
}
#Preview {
    ItemList()
}
