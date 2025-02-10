//
//  ItemCardView.swift
//  Flow
//
//  Created by Joseph DeWeese on 1/31/25.
//

import SwiftUI
import SwiftData




struct ItemCardView: View {
    @Environment(\.modelContext) private var context
    let item: Item
 
    var body: some View {
        NavigationStack{
            SwipeAction(cornerRadius: 10, direction: .trailing) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.ultraThinMaterial.opacity(.greatestFiniteMagnitude))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack(alignment: .leading){
                        
                        HStack(spacing: 12){
                            
                            ZStack {
                                ///category tag
                                Text(item.category)
                                    .padding(4)
                                    .foregroundStyle(.white)
                                    .background(item.color.gradient, in: .rect(cornerRadius: 3))
                                    .contentShape(.rect)
                                    .fontDesign(.serif)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 14))
                                    .padding(.leading, 150)
                                    .shadow(color: .black, radius: 2, x: 2, y: 2)
                            }
                        }
                        //MARK:  MAIN BODY
                        HStack{
                            //MARK:  ICON
                            Text("\(String(item.title.prefix(1)))")
                                .font(.title)
                                .fontDesign(.serif)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .shadow(color: .black, radius: 2, x: 1, y: 1)
                                .frame(width: 35, height: 35)
                                .background(item.color.gradient.opacity(0.8))
                                .padding(5)
                            Text(item.title)
                                .font(.system(size: 18))
                                .fontDesign(.serif)
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary)
                        }
                        HStack{
                            Spacer()
                            //MARK:  DATE CREATED DATA LINE
                            Text("Date Created: ")
                                .foregroundStyle(.gray)
                                .fontDesign(.serif)
                                .font(.system(size: 12))
                            Image(systemName: "calendar.badge.clock")
                                .font(.footnote)
                                .fontDesign(.serif)
                                .foregroundStyle(.gray)
                                .font(.system(size: 12))
                            Text(item.dateAdded.formatted(.dateTime))
                                .fontDesign(.serif)
                                .foregroundColor(.secondary)
                                .font(.system(size: 12))
                            Spacer()
                        }
                        .fontWeight(.semibold)
                        .padding(.horizontal, 4)
                        .padding(.bottom, 4)
                        //MARK:  BRIEF DESCRIPTION
                        if !item.remarks.isEmpty {
                            Text(item.remarks)
                                .fontDesign(.serif)
                                .font(.system(size: 14))
                                .foregroundStyle(.blue)
                                .padding(.horizontal, 4)
                                .lineLimit(3)
                                .padding(.bottom, 4)
                        }
                        
                        //MARK:  TAGS
                        if let tags = item.tags {
                            ViewThatFits {
                                TagsStackView(tags: tags)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    TagsStackView(tags: tags)
                                }
                            }
                            .padding(.horizontal, 4)
                        }
                    }///overlay
                    .padding(4)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(.linearGradient(Gradient(colors: [Color.launchAccent, Color.blue, Color.orange]), startPoint: .leading, endPoint: .trailing), lineWidth: 2))
                                      
                }
                .padding(.horizontal, 7)
                .padding( 4)
            } actions: {
                Action(tint: .red, icon: "trash", action: {
                    context.delete(item)
                    //WidgetCentrer.shared.reloadAllTimneLines
                })
            }
        }
    }
}
#Preview {
    ItemCardView( item: Item(title: "Dynamic Transformation", remarks: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", dateAdded: Date.now, dateDue: Date.distantFuture, dateCompleted: Date.distantFuture, category: .upcoming, status: .Active, tintColor: TintColor(color: "Blue", value: .blue)))
}
