//
//  ContentView.swift
//  Flow
//
//  Created by Joseph DeWeese on 1/31/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    /// View Properties
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var showAddItemSheet: Bool = false
    @State private var selectedItem: Item?
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var filter = ""
    @State private var activeTab: Category = .today
    @State private var selectedCategory: Category = .today
    @State private var searchText: String = ""
    @State private var isSearchActive: Bool = false
    
    /// Scroll Properties
    @State private var scrollOffset: CGFloat = 0
    @State private var topInset: CGFloat = 0
    @State private var startTopInset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    CustomTabBar(activeTab: $activeTab)
                        .frame(height: isSearchActive ? 0 : nil, alignment: .top)
                        .opacity(isSearchActive ? 0 : 1)
                        .padding(.bottom, isSearchActive ? 0 : 10)
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
                    Text(activeTab.rawValue + (activeTab == .dates ? "" : " Objectives"))
                        .font(.caption2)
                        .fontDesign(.serif)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    /// ItemList
                    ItemList()
                }
                .toolbar{
                    ToolbarItem(placement: .topBarLeading, content: {
                        Button{
                            print("profile")
                  //          HapticManager.notification(type: .success)
                        } label: {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue).opacity(0.6)
                        }
                        
                    })
                    ToolbarItem(placement: .topBarTrailing) {
                        Button{
                            showAddItemSheet = true
                   //         HapticManager.notification(type: .success)
                        } label: {
                            Image(systemName: "plus")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 40, height: 40)
                                .background(.blue.gradient, in: .circle)
                                .contentShape(.circle)
                        }
                        .sheet(isPresented: $showAddItemSheet) {
                            AddItemView()
                                .presentationDetents([.medium])
                        }
                        
                    }
                }
                
            }
            .padding(15)
            .zIndex(0)
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
            .background(.gray.opacity(0.1))
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
        }  .blur(radius: showAddItemSheet ? 8 : 0)
    }
}

#Preview {
    ContentView()
}
