//
//  AddItemView.swift
//  Flow
//
//  Created by Joseph DeWeese on 2/1/25.
//

import SwiftUI
import SwiftData

struct AddItemView: View {
    //MARK:  PROPERTIES
    /// Env Properties
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var editItem: Item?
    /// View Properties
    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var dateAdded: Date = .now
    @State private var dateDue: Date = .now
    @State private var dateCompleted: Date = .now
    @State private var category: Category = .today
    /// Random Tint
    @State var tint: TintColor = tints.randomElement()!
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 15) {
                    Section("Choose Category") {
                        //MARK:  CATEGORY CHECKBOX
                        CategoryCheckBox(category: $category)
                            .padding(7)
                    }  .foregroundStyle(.primary)
                    //MARK:  DATE PICKER GROUP
                    Section("Timeline") {
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
                                    .font(.system(size: 14))
                                Text(dateAdded.formatted(.dateTime))
                                    .fontDesign(.serif)
                                    .foregroundColor(.primary)
                                    .font(.system(size: 14))
                            }
                            if category == .upcoming {
                                DatePicker("Date Due", selection: $dateDue, in: dateAdded..., displayedComponents: .date)
                            }
                            if category == .dates {
                                DatePicker("Date Due", selection: $dateDue, displayedComponents: .date)
                            }
                            if category == .complete {
                                DatePicker("Date Completed", selection: $dateCompleted, displayedComponents: .date)
                            }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.secondary, lineWidth: 1))
                    }
                   
                    .padding(.horizontal, 7)
                    ///title
                    Section("Title") {
                        ZStack(alignment: .topLeading) {
                            if title.isEmpty {
                                Text("Enter title here...")
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(3)
                                    .padding(10)
                                    .fontDesign(.serif)
                                    .foregroundStyle(.secondary)
                            }
                            TextEditor(text: $title)
                                .scrollContentBackground(.hidden)
                                .background(Color.gray.opacity(0.1))
                                .font(.system(size: 16))
                                .fontDesign(.serif)
                        }
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.secondary, lineWidth: 1))
                    }
                    .padding(.horizontal, 7)
                    ///description
                    Section("Brief Description") {
                        ZStack(alignment: .topLeading) {
                            if remarks.isEmpty {
                                Text("Brief description here...")
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(3)
                                    .padding(10)
                                    .foregroundStyle(.secondary)
                            }
                            TextEditor(text: $remarks)
                                .scrollContentBackground(.hidden)
                                .background(Color.gray.opacity(0.1))
                                .font(.system(size: 16))
                                .fontDesign(.serif)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke(Color.gray, lineWidth: 1))
                        }
                    }
                    .fontDesign(.serif)
                    .background(.background)
                }  .padding(.horizontal, 7)
            }
            .padding(.horizontal, 10)
            .fontDesign(.serif)
            //MARK:  TOOLBAR
                .toolbar{
                    ToolbarItem(placement: .topBarLeading, content: {
                        Button {
                            HapticManager.notification(type: .success)
                            dismiss()
                        } label: {
                            Text("Cancel")
                                .fontDesign(.serif)
                        }
                        .buttonStyle(.automatic)
                    })
                    ToolbarItem(placement: .principal, content: {
                        LogoView()
                    })
                    ToolbarItem(placement:.topBarTrailing, content: {
                        Button {
                            /// Saving objectiveTask
                            save()
                        
                        } label: {
                            Text("Save")
                                .font(.callout)
                                .fontDesign(.serif)
                                .foregroundStyle(.white)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(title.isEmpty || remarks.isEmpty )
                        .padding(.horizontal, 2)
                    })
                }
                .padding(.top, -25)
        }
    }
    //MARK: - Private Methods -
    private  func save() {
        /// Saving objectiveTask
        let item = Item(title: title, remarks: remarks, dateAdded: dateAdded, dateDue: dateDue, dateCompleted: dateCompleted, category: category, tintColor: tint)
        do {
            context.insert(item)
            try context.save()
            /// After Successful objectiveTask Creation, Dismissing the View
            HapticManager.notification(type: .success)
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}
#Preview {
    AddItemView()
}
