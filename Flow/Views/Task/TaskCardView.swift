//
//  TaskCardView.swift
//  Flow
//
//  Created by Joseph DeWeese on 2/4/25.
//

import SwiftUI

struct TaskCardView: View {
    @Environment(\.modelContext) private var context
    let itemTask: ItemTask

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial.opacity(.greatestFiniteMagnitude))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(alignment: .leading) {
                //MARK:  MAIN BODY OF CARD
                HStack {
                    //MARK:  ICON
                    Text(itemTask.taskName)
                        .font(.system(size: 17))
                        .fontDesign(.serif)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                }
                VStack(alignment: .center) {
                    HStack {
                        Spacer()

                        Text(
                            itemTask.taskRemark
                                ?? "No Description Available"
                        )
                        .fontDesign(.serif)
                        .font(.system(size: 14))
                        .foregroundStyle(.blue)
                        .padding(.horizontal, 4)
                        .lineLimit(3)

                        Spacer()
                    }

                }
            }
        }

    }
}
#Preview {
    TaskCardView(
        itemTask: ItemTask(
            taskName: "Test", taskRemark: "Test", isCompleted: false))
}

