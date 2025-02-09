//
//  CustomTabBar.swift
//  Flow
//
//  Created by Joseph DeWeese on 1/31/25.
//

import SwiftUI
import SwiftData

struct CustomTabBar: View {
    
    @Binding var activeTab: Category
        @Environment(\.colorScheme) private var scheme
        var body: some View {
            GeometryReader {
                let size = $0.size
                let allOffset = size.width - (10 * CGFloat(Category.allCases.count - 1))
                
                HStack(spacing: 5) {
                    HStack(spacing: activeTab == .dates ? -15 : 8) {
                        ForEach(Category.allCases.filter({ $0 != .dates }), id: \.rawValue) { tab in
                            ResizableTabButton(tab)
                        }
                        .fontDesign(.serif)
                    }
                    
                    if activeTab == .dates {
                        ResizableTabButton(.dates)
                            .transition(.offset(x: allOffset))
                    }
                }
                .padding(.horizontal, 10)
            }
            .frame(height: 40)
        }
        //MARK:  RESIZABLE TAB BUTTON
        @ViewBuilder
        func ResizableTabButton(_ tab: Category) -> some View {
            HStack(spacing: 8) {
                Image(systemName: tab.symbolImage)
                    .opacity(activeTab != tab ? 1 : 0)
                    .overlay {
                        Image(systemName: tab.symbolImage)
                            .symbolVariant(.fill)
                            .opacity(activeTab == tab ? 1 : 0)
                    }
                if activeTab == tab {
                    Text(tab.rawValue)
                        .font(.callout)
                        .fontDesign(.serif)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                }
            }
            .foregroundStyle(tab == .dates ? schemeColor : activeTab == tab ? .white : .gray)
            .frame(maxHeight: .infinity)
            .frame(maxWidth: activeTab == tab ? .infinity : nil)
            .padding(.horizontal, activeTab == tab ? 10 : 15)
            .background {
                Rectangle()
                    .fill(activeTab == tab ? tab.color : .inActiveTab)
            }
            .clipShape(.rect(cornerRadius: 10, style: .circular))
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.background)
                    .padding(activeTab == .dates && tab != .dates ? -3 : 3)
            }
            .contentShape(.rect)
            .onTapGesture {///double tap of tab to render the "dates" tab viewable for display 
                guard tab != .dates else { return }
                withAnimation(.bouncy) {
                    if activeTab == tab {
                        activeTab = .dates
                    } else {
                        activeTab = tab
                    }
                }
            }
        }
        
        var schemeColor: Color {
            scheme == .dark ? .black : .white
        }
    }
