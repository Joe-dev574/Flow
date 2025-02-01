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
    @State private var category: Category = .today
    /// Random Tint
    @State var tint: TintColor = tints.randomElement()!
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 15) {
                    Text("Category")
                        .font(.callout)
                        .fontDesign(.serif)
                        .foregroundStyle(.gray)
                    
                    CategoryCheckBox(category: $category)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1))
                        .padding(10)
                    
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
                    }
                        
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
                    }
                    .padding(.horizontal, 7)
                    .fontDesign(.serif)
                    .background(.background)
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
                            .disabled(title.isEmpty || remarks.isEmpty)
                            .padding(.horizontal, 2)
                        })
                    }
                }
            }
        }
    
    //MARK: - Private Methods -
    private  func save() {
        /// Saving Task
        let item = Item(title: title, remarks: remarks,category: category, tintColor: tint)
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
    @ViewBuilder
    func LogoView() -> some View {
        VStack(alignment: .leading, spacing: 6){
            HStack {
                Spacer()
                ZStack{
                    Image(systemName: "memorychip")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .foregroundColor(.blue).opacity(0.3)
                    HStack {
                        Text("Mind")
                            .font(.callout)
                            .fontDesign(.serif)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .offset(x: 13, y: 1)
                        Text("Map")
                            .font(.callout)
                            .fontDesign(.serif)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .offset(x: 5, y: 1)
                      
                        Text("1.0")
                            .font(.caption)
                            .fontDesign(.serif)
                            .fontWeight(.regular)
                            .padding(.leading, 10)
                            .foregroundColor(.blue)
                            .offset(x: -15, y: -5)
                    }.offset(x: 5)
                    
                }
                Spacer()
            }
            }
        }
}

#Preview {
    AddItemView()
}
