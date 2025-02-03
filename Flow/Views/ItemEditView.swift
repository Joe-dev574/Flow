//
//  ItemEditView.swift
//  Flow
//
//  Created by Joseph DeWeese on 1/31/25.
//

import SwiftUI

struct ItemEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    let item: Item
    @State private var status = Status.Hold
    @State private var showImagePicker = false
    @State private var showImageEditor = false
    @State private var title = ""
    @State private var itemColor = Color.accentColor
    @State private var remarks = ""
    @State private var dateAdded: Date = .init()
    @State private var dateStarted: Date = .init()
    @State private var dateDue: Date = .init()
    @State private var dateCompleted: Date = .init()
    @State private var category: Category = .today
    @State private var showTags = false
    @State var tint: TintColor = tints.randomElement()!
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                Text("Preview")
                    .font(.caption)
                    .fontDesign(.serif)
                    .foregroundStyle(.gray)
                ///Preview Item Card
                ItemCardView(item: .init(
                    title: title.isEmpty ? "Title" : title,
                    remarks: remarks.isEmpty ? "Remarks" : remarks,
                    dateAdded: dateAdded,
                    dateDue: dateDue,
                    category: category,
                    tintColor: tint))
                
                DashControlView(item: item, status: $status)
                
                
                
                
                //MARK:  CATEGORY CHECK BOX
                Text("Category:")
                    .font(.system(size: 16))
                    .fontDesign(.serif)
                    .foregroundStyle(.gray)
                    .padding(.bottom, 3)
                CategoryCheckBox(category: $category)
                GroupBox{
                    HStack{
                        //MARK:  DATE CREATED DATA LINE
                        Text("Date Created: ")
                            .foregroundStyle(.primary)
                            .fontDesign(.serif)
                            .font(.callout)
                        Spacer()
                        Image(systemName: "calendar.badge.clock")
                            .fontDesign(.serif)
                            .foregroundStyle(.primary)
                            .font(.system(size: 18))
                        Text(dateAdded.formatted(.dateTime))
                            .fontDesign(.serif)
                            .foregroundColor(.primary)
                            .font(.system(size: 18))
                    }
                    //MARK:  DATE PICKER LOGIC
                    if category == .upcoming {
                        DatePicker("Date Due", selection: $dateDue, in: dateAdded..., displayedComponents: .date)
                    }
                    if category == .events {
                        DatePicker("Date Due", selection: $dateDue, displayedComponents: .date)
                    }
                    if category == .complete {
                        DatePicker("Date Completed", selection: $dateCompleted, displayedComponents: .date)
                    }
                    if category == .today {
                        DatePicker("Date Due", selection: $dateDue, displayedComponents: .date)
                    }
                    VStack(alignment: .center, spacing: 7){
                        ///title
                        Text("Item Title")
                            .font(.system(size: 16))
                            .fontDesign(.serif)
                            .foregroundStyle(.gray)
                        TextField("Item Title", text:$title)
                            .font(.system(size: 16))
                            .fontDesign(.serif)
                            .padding()
                            .foregroundStyle(.primary)
                            .background(Color.gray.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1))
                            .padding(.bottom, 10)
                        ///description
                        Text("Brief Description")
                            .font(.system(size: 16))
                            .fontDesign(.serif)
                            .foregroundStyle(.gray)
                        ZStack(alignment: .topLeading) {
                            if remarks.isEmpty {
                                Text("Brief Description...")
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(3)
                                    .foregroundStyle(.primary)
                            }
                            TextEditor(text: $remarks)
                                .scrollContentBackground(.hidden)
                                .background(Color.gray.opacity(0.1))
                                .font(.system(size: 16))
                                .fontDesign(.serif)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            
                        }
                        ///   if let tags = item.tags {
                        if item.tags != nil {
                            ViewThatFits {
                                //         TagsStackView(tags: tags)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    //           TagsStackView(tags: tags)
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
                        }
                    }
                    .padding()
                    Divider()
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    if changed {
                        Button{
                            HapticManager.notification(type: .success)
                            item.status = status.rawValue
                            item.title = title
                            item.category = category.rawValue
                            item.remarks = remarks
                            item.dateAdded = dateAdded
                            item.dateDue = dateDue
                            item.dateCompleted = dateCompleted
                            dismiss()
                        }  label: {
                            ZStack{
                                Text("Update")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .padding(.top, 15)
            .onAppear {
                title = item.title
                remarks = item.remarks
                dateAdded = item.dateAdded
                dateDue = item.dateDue
                dateCompleted = item.dateCompleted
                status = Status(rawValue: item.status)!
                category = Category(rawValue: item.category)!
                
            }
        }
        var changed: Bool {
            status != Status(rawValue: item.status)!
            || title != item.title
            || remarks != item.remarks
            || category != Category(rawValue: item.category)!
            || dateAdded != item.dateAdded
            || dateDue != item.dateDue
            || dateCompleted != item.dateCompleted
            
        }
    }
    
}


