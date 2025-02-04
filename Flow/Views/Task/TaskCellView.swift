//
//  TaskCellView.swift
//  Flow
//
//  Created by Joseph DeWeese on 2/4/25.
//

import SwiftUI
import SwiftData

enum TaskCellEvents {
    case onChecked(ObjectiveTask, Bool)
    case onSelect(ObjectiveTask)
}

struct TaskCellView: View {
    
    let objectiveTask: ObjectiveTask
    let onEvent: (TaskCellEvents) -> Void
    @State private var checked: Bool = false
    
    private func formatTaskDate(_ date: Date) -> String {
        
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
    
    var body: some View {
        HStack(alignment: .top) {
            
            Image(systemName: checked ? "circle.inset.filled": "circle")
                .font(.title2)
                .padding([.trailing], 5)
                .onTapGesture {
                    checked.toggle()
                    onEvent(.onChecked(objectiveTask, checked))
                }
            
            VStack {
                Text(objectiveTask.taskName)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let taskRemark = objectiveTask.taskRemark {
                    Text(taskRemark)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                HStack {
                    
                    if let taskDate = objectiveTask.taskDate {
                        Text(formatTaskDate(taskDate))
                    }
                    
                    if let taskTime = objectiveTask.taskTime {
                        Text(taskTime, style: .time)
                    }
                    
                }.font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
            
        }.contentShape(Rectangle())
            .onTapGesture {
                onEvent(.onSelect(objectiveTask))
            }
    }
}

struct TaskCellViewContainer: View {
    
    @Query(sort: \ObjectiveTask.taskName) private var objectiveTasks: [ObjectiveTask]
    
    var body: some View {
        TaskCellView(objectiveTask: objectiveTasks[0]) { _ in
            
        }
    }
}

#Preview { @MainActor in
    TaskCellViewContainer()
    
}

