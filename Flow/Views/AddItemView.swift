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
                    Text("Choose Category Status")
                        .font(.callout)
                        .fontDesign(.serif)
                        .foregroundStyle(.gray)
                    //MARK:  CATEGORY CHECKBOX
                    CategoryCheckBox(category: $category)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1))
                        .padding(7)
                    //MARK:  DATE PICKER GROUP
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
                        if category == .upcoming {
                            DatePicker("Date Due", selection: $dateDue, in: dateAdded..., displayedComponents: .date)
                        }
                        if category == .events {
                            DatePicker("Date Due", selection: $dateDue, displayedComponents: .date)
                        }
                        if category == .complete {
                            DatePicker("Date Completed", selection: $dateCompleted, displayedComponents: .date)
                        }
                    }
                        ///title
                        Text("Title")
                            .font(.system(size: 16))
                            .fontDesign(.serif)
                            .foregroundStyle(.secondary)
                        ZStack(alignment: .topLeading) {
                            if title.isEmpty {
                                Text("Enter title here...")
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(3)
                                    .padding(10)
                                    .foregroundStyle(.secondary)
                            }
                            TextEditor(text: $title)
                                .scrollContentBackground(.hidden)
                                .background(Color.gray.opacity(0.1))
                                .font(.system(size: 16))
                                .fontDesign(.serif)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1))
                        }  .padding(.horizontal, 7)
                        
                        ///description
                        Text("Brief Description")
                            .font(.system(size: 16))
                            .fontDesign(.serif)
                            .foregroundStyle(.secondary)
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
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        }
                    .padding(.horizontal, 7)
                    .fontDesign(.serif)
                    .background(.background)
                }
            }.padding(.horizontal, 10)
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
                                /// Saving Task
                                save()
                                HapticManager.notification(type: .success)
                                dismiss()
                            } label: {
                                Text("Save")
                                    .fontDesign(.serif)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(title.isEmpty || remarks.isEmpty )
                            .padding(.horizontal, 2)
                        })
                    }
                }
            }
    //MARK: - Private Methods -
    private  func save() {
        /// Saving Task
        let item = Item(title: title, remarks: remarks, dateAdded: dateAdded, dateDue: dateDue, dateCompleted: dateCompleted, category: category, tintColor: tint)
        do {
            context.insert(item)
            try context.save()
            /// After Successful Task Creation, Dismissing the View
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
        HapticManager.notification(type: .success)
        dismiss()
    }
   
    @ViewBuilder
    func CustomSection(_ title: String, _ hint: String, value: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text(title)
                .font(.callout)
                .fontDesign(.serif)
                .foregroundStyle(.gray)
              
            
            TextField(hint, text: value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(.gray.opacity(0.10), in: .rect(cornerRadius: 10))
        }).padding(.horizontal, 7)
    }
            }
#Preview {
    AddItemView()
}
