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
                        .background {
                            let progress = min(max((scrollOffset + startTopInset - 110) / 15, 0), 1)
                            ZStack(alignment: .bottom) {
                                Rectangle()
                                    .fill(.ultraThinMaterial)
                                /// Divider
                                Rectangle()
                                    .fill(.gray.opacity(0.3))
                                    .frame(height: 1)
                            }
                            .padding(.top, -topInset)
                            .opacity(progress)
                        }
                        .offset(y: (scrollOffset + topInset) > 0 ? (scrollOffset + topInset) : 0)
                        .zIndex(1000)
                    
                    LazyVStack(alignment: .leading) {
                        Text(activeTab.rawValue + (activeTab == .dates ? " that repeat. " : " Objectives"))
                            .font(.callout)
                            .fontDesign(.serif)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        //MARK: CATEGORY FILTER VIEW
                        CategoryFilterView(startDate: startDate, endDate:endDate, category: activeTab) { items in
                            ForEach(items) { item in
                                ItemCardView(item: item)
                                    .onTapGesture {
                                        selectedItem = item
                                    }
                            }
                        }
                        .animation(.smooth, value: activeTab)
                    }
                    .padding(1)
                    .zIndex(0)
                }
            }
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
