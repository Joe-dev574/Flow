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
    @State private var showAddItemSheet: Bool = false
    @State private var activeTab: Category = .today
    /// Scroll Properties
    @State private var scrollOffset: CGFloat = 0
    @State private var topInset: CGFloat = 0
    @State private var startTopInset: CGFloat = 0
    
    var body: some View {
        ///no scrollview here- this creates hard stop for item list scroll view of 1st layer customtabbar and then Lazy vstck for item cards
        NavigationStack {
            VStack{
                ItemList()
            }
            //MARK:  TOOL BAR
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
                ToolbarItem(placement: .principal, content: {
                        LogoView()
                })
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        showAddItemSheet = true
                        //         HapticManager.notification(type: .success)
                    } label: {
                        Image(systemName: "plus")
                            .font(.callout)
                            .foregroundStyle(.white)
                            .frame(width: 40, height: 40)
                            .background(.blue.gradient, in: .circle)
                            .contentShape(.circle)
                    }
                    .sheet(isPresented: $showAddItemSheet) {
                        AddItemView()
                            .presentationDetents([.large])
                    }
                }
            }
            
        }
        .blur(radius: showAddItemSheet ? 8 : 0)
      
    }
}
#Preview {
    ContentView()
}
