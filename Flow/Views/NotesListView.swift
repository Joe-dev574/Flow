//
//  NotesListView.swift
//  Flow
//
//  Created by Joseph DeWeese on 2/2/25.
//

import SwiftUI

struct NotesListView: View {
    @Environment(\.modelContext) private var modelContext
    let item: Item
    @State private var text = ""
    @State private var page = ""
    @State private var selectedNote: Note?
    var isEditing: Bool {
        selectedNote != nil
    }
    var body: some View {
        GroupBox {
            HStack {
                LabeledContent("Page") {
                    TextField("page #", text: $page)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 150)
                    Spacer()
                }
                if isEditing {
                    Button("Cancel") {
                        page = ""
                        text = ""
                        selectedNote = nil
                    }
                    .buttonStyle(.bordered)
                }
                Button(isEditing ? "Update" : "Create") {
                    if isEditing {
                        selectedNote?.text = text
                        selectedNote?.page = page.isEmpty ? nil : page
                        page = ""
                        text = ""
                        selectedNote = nil
                    } else {
                        let note = page.isEmpty ? Note(text: text) : Note(text: text, page: page)
                        item.notes?.append(note)
                        text = ""
                        page = ""
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(text.isEmpty)
            }
            TextEditor(text: $text)
                .border(Color.secondary)
                .frame(height: 100)
        }
        .padding(.horizontal)
        List {
            let sortedNotes = item.notes?.sorted(using: KeyPathComparator(\Note.creationDate)) ?? []
            ForEach(sortedNotes) { note in
                VStack(alignment: .leading) {
                    Text(note.creationDate, format: .dateTime.month().day().year())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(note.text)
                    HStack {
                        Spacer()
                        if let page = note.page, !page.isEmpty {
                            Text("Page: \(page)")
                        }
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedNote = note
                    text = note.text
                    page = note.page ?? ""
                }
            }
            .onDelete { indexSet in
                withAnimation {
                    indexSet.forEach { index in
                        let note = sortedNotes[index]
                        item.notes?.forEach({ itemNote in
                            if note.id == itemNote.id {
                                modelContext.delete(note)
                            }
                        })
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Notes")
    }
}

