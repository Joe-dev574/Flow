//
//  DatePickerView.swift
//  Flow
//
//  Created by Joseph DeWeese on 2/9/25.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var dateAdded: Date
    @State private var status = Status.Upcoming
    @Binding var dateStarted: Date
    @Binding var dateDue: Date
    @State private var firstView = true
    @Binding var dateCompleted: Date
    let category: Category
    var body: some View {
        GroupBox {
            GroupBox {
                LabeledContent {
                    DatePicker("", selection: $dateAdded, displayedComponents: .date)
                } label: {
                    Text("Date Added")
                }
                if status == .Active || status == .Completed {
                    LabeledContent {
                        DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                    } label: {
                        Text("Date Started")
                    }
                }
                if status == .Completed {
                    LabeledContent {
                        DatePicker("", selection: $dateCompleted, in: dateStarted..., displayedComponents: .date)
                    } label: {
                        Text("Date Completed")
                    }
                }
            }
            .foregroundStyle(.secondary)
        }
    }
}
