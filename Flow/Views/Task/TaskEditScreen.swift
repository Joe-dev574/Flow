//
//  TaskEditScreen.swift
//  Flow
//
//  Created by Joseph DeWeese on 2/4/25.
//

import SwiftUI
import SwiftData



struct TaskEditScreen: View {
    @Environment(\.dismiss) private var dismiss
    let objectiveTask: ObjectiveTask
    @State private var taskName: String = ""
    @State private var taskRemark: String = ""
    @State private var taskDate: Date = .now
    @State private var taskTime: Date = .now
    
    @State private var showCalender: Bool = false
    @State private var showTime: Bool = false
    
    private func updateObjectiveTask() {
        objectiveTask.taskName = taskName
        objectiveTask.taskRemark = taskRemark.isEmpty ? nil: taskRemark
        objectiveTask.taskDate = showCalender ? taskDate: nil
        objectiveTask.taskTime = showTime ? taskTime: nil
        
        // schedule a local notification
//        NotificationManager.scheduleNotification(userData: UserData(title: objectiveTask.title, body: reminder.notes, date: objectiveTask.reminderDate, time: objectiveTask.reminderTime))
    }
    
    private var isFormValid: Bool {
        !taskName.isEmptyOrWhitespace
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $taskName)
                TextField("Description", text: $taskRemark)
            }
            
            Section {
               
                HStack {
                    Image(systemName: "calendar")
                        .foregroundStyle(.red)
                        .font(.title2)
                    
                    Toggle(isOn: $showCalender) {
                        EmptyView()
                    }
                }
                
                if showCalender {
                    
                    DatePicker("Select Date", selection: $taskDate, in: .now..., displayedComponents: .date)
                }
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundStyle(.blue)
                        .font(.title2)
                    Toggle(isOn: $showTime) {
                        EmptyView()
                    }
                }.onChange(of: showTime) {
                    if showTime {
                        showCalender = true
                    }
                }
                
                if showTime {
                    DatePicker("Select Time", selection: $taskTime, displayedComponents: .hourAndMinute)
                    
                }
                
            }
            
        }.onAppear(perform: {
            taskName = objectiveTask.taskName
            taskRemark = objectiveTask.taskRemark ?? ""
            taskDate = objectiveTask.taskDate ?? Date()
            taskTime = objectiveTask.taskTime ?? Date()
            showCalender = objectiveTask.taskTime != nil
            showTime = objectiveTask.taskTime != nil
        })
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    updateObjectiveTask()
                    dismiss()
                }.disabled(!isFormValid)
            }
        }
    }
}

struct ReminderEditScreenContainer: View {
    
    @Query(sort: \ObjectiveTask.taskName) private var objectiveTasks: [ObjectiveTask]
    
    var body: some View {
        TaskEditScreen(objectiveTask: objectiveTasks[0])
    }
}

#Preview {
    NavigationStack {
        TaskEditScreen(objectiveTask: ObjectiveTask(taskName: "Test", isCompleted: false))
    }
}
