//
//  ItemList.swift
//  Flow
//
//  Created by Joseph DeWeese on 1/31/25.
//

import SwiftUI
import SwiftData


struct ItemList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var selectedItem: Item?
    @State private var showEditItemSheet: Bool = false
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var filter = ""
    @State private var activeTab: Category = .today
    /// Scroll Properties
    @State private var scrollOffset: CGFloat = 0
    @State private var topInset: CGFloat = 0
    @State private var startTopInset: CGFloat = 0
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical) {
                VStack{
                    CustomTabBar(activeTab: $activeTab)
                    
                    
                    LazyVStack(alignment: .leading) {
                        Text(activeTab.rawValue + (activeTab == .dates ? " Thou Shalt Not Forget! " : " Shit"))
                            .font(.title3)
                            .fontDesign(.serif)
                            .foregroundStyle(.gray)
                            .padding(.leading, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        //MARK: CATEGORY FILTER VIEW
                        CategoryFilterView(startDate: startDate, endDate:endDate, category: activeTab) { items in
                            ForEach(items) { item in
                                ItemCardView(item: item)
                                    .onTapGesture {
                                        selectedItem = item
                                    }///long press gesture to edit item card - quick press, task view
                                    .onLongPressGesture(minimumDuration: 0.5){
                                        showEditItemSheet = true
                                        HapticManager.notification(type: .success)
                                    }
                                    .sheet(isPresented: $showEditItemSheet) {
                                        ItemEditView()
                                            .presentationDetents([.large])
                                    }
                            }
                        }
                    }
                    .animation(.smooth, value: activeTab)
                }
                .padding(1)
                .zIndex(0)
            }
            .navigationDestination(item: $selectedItem) { item in
                ItemTaskView()}
                    .onScrollGeometryChange(for: CGFloat.self, of: {
                        $0.contentOffset.y
                    }, action: { oldValue, newValue in
                        scrollOffset = newValue
                    })
                    .onScrollGeometryChange(for: CGFloat.self, of: {
                        $0.contentInsets.top
                    }, action: { oldValue, newValue in
                        if startTopInset == .zero {
                            startTopInset = newValue
                        }
                        
                        topInset = newValue
                    })
            }
        }
    }


#Preview {
    ItemList()
}
