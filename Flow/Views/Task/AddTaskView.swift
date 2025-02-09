//
//  AddObjectiveTaskView.swift
//  Flow
//
//  Created by Joseph DeWeese on 2/4/25.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    let itemTask: ItemTask
    @State private var taskName: String = ""
    @State private var taskRemark: String = ""
    var body: some View {
        ///title
        Text("Title")
            .font(.system(size: 16))
            .fontDesign(.serif)
            .foregroundStyle(.secondary)
        ZStack(alignment: .topLeading) {
            if taskName.isEmpty {
                Text("Enter title here...")
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .padding(10)
                    .foregroundStyle(.secondary)
            }
            TextEditor(text: $taskName)
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
            if taskRemark.isEmpty {
                Text("Brief description here...")
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .padding(10)
                    .foregroundStyle(.secondary)
            }
            TextEditor(text: $taskRemark)
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
}
#Preview {
    AddTaskView(itemTask: ItemTask(taskName: "Testing UI"))
}
