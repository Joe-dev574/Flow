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
                                    .font(.system(size: 14))
                                    .shadow(color: .black, radius: 2, x: 2, y: 2)
                            }
                        }
                            //MARK:  MAIN BODY OF CARD
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
                                    .font(.system(size: 17))
                                    .fontDesign(.serif)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)
                            }
                            VStack(alignment: .center){
                                HStack{
                                    Spacer( )
                                    
                                    if !item.remarks.isEmpty {
                                        Text(item.remarks)
                                            .fontDesign(.serif)
                                            .font(.system(size: 14))
                                            .foregroundStyle(.blue)
                                            .padding(.horizontal, 4)
                                            .lineLimit(3)
                                    }
                                    Spacer( )
                                }
                                HStack {
                                    //MARK:  DATE CREATED DATA LINE
                                    Text("Date Created: ")
                                        .foregroundStyle(.gray)
                                        .fontDesign(.serif)
                                        .font(.system(size: 10))
                                    Image(systemName: "calendar.badge.clock")
                                        .font(.footnote)
                                        .fontDesign(.serif)
                                        .foregroundStyle(.gray)
                                        .font(.system(size: 10))
                                    Text(item.dateAdded.formatted(.dateTime))
                                        .fontDesign(.serif)
                                        .foregroundColor(.secondary)
                                        .font(.system(size: 10))
                                }
                                .padding(.top, 5)
                                .padding(.bottom, 3)
                                if let tags = item.tags {
                                    ViewThatFits {
                                        TagsStackView(tags: tags)
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            TagsStackView(tags: tags)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                }.padding( 2)
            } actions: {
                Action(tint: .red, icon: "trash", action: {
                    context.delete(item)
                    //WidgetCentrer.shared.reloadAllTimneLines
                })
            }
        }
    }
}
