//
//  TaskListView.swift
//  Flow
//
//  Created by Joseph DeWeese on 2/4/25.
//

import SwiftUI
import SwiftData




struct TaskListView: View {
        @Environment(\.modelContext) private var context
            let objectiveTasks: [ObjectiveTask]
        @State private var selectedObjectiveTask: ObjectiveTask? = nil
        @State private var showTaskEditScreen: Bool = false
        
        @State private var taskIdAndDelay: [PersistentIdentifier: Delay] = [: ]
        
        private func deleteTask(_ indexSet: IndexSet) {
            guard let index = indexSet.last else { return }
            let objectiveTask = objectiveTasks[index]
            context.delete(objectiveTask)
        }
        
        var body: some View {
            List {
                ForEach(objectiveTasks) { objectiveTask in
                    TaskCellView(objectiveTask: objectiveTask) { event in
                        switch event {
                        case .onChecked(let objectiveTask, let checked):
                            
                            // get the delay from the dictionary
                            var delay = taskIdAndDelay[objectiveTask.persistentModelID]
                            if let delay {
                                // cancel
                                delay.cancel()
                                taskIdAndDelay.removeValue(forKey: objectiveTask.persistentModelID)
                                
                            } else {
                                // create a new delay and add to the dictionary
                                delay = Delay()
                                taskIdAndDelay[objectiveTask.persistentModelID] = delay
                                delay?.performWork {
                                    objectiveTask.isCompleted = checked
                                }
                            }
                            
                        case .onSelect(let task): // for editing
                            selectedObjectiveTask = objectiveTask
                        }
                    }
                }.onDelete(perform: deleteTask)
            }.sheet(item: $selectedObjectiveTask, content: { selectedObjectiveTask in
                NavigationStack {
                    TaskEditScreen(objectiveTask: selectedObjectiveTask)
                }
            })
        }
    }

