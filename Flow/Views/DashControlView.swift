//
//  DashControlView.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/29/24.
//

import SwiftUI

struct DashControlView: View {
    let item: Item
    /// Env Properties
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var showTags: Bool = false
    @Binding var status: Status
    
    var body: some View {
        VStack {
            //MARK:  STATUS PICKER
            Text("Dash Controls")
                .foregroundStyle(.gray)
            
            HStack {
                Spacer( )
                Picker("Status", selection: $status) {
                    ForEach(Status.allCases) { status in
                        Text(status.descr).tag(status) 
                    }
                    .fontDesign(.serif)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                }
                .background(.thinMaterial.shadow(.drop(color: .black.opacity(0.95), radius: 4)), in: .rect(cornerRadius: 10))
                .pickerStyle(.menu)
                .buttonStyle(.bordered)
                Spacer( )
                //MARK:  TAGS BUTTON
                Button("Tags", systemImage: "scope") {
                    showTags.toggle()
                }/// TAG BUTTON FONT SIZE AND COLOR ADJUSTMENTS
                .fontDesign(.serif)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundStyle(.blue)
                .frame(width: 120, height: 35)
                .background(.thinMaterial.shadow(.drop(color: .black.opacity(0.95), radius: 4)), in: .rect(cornerRadius: 10))
                .sheet(isPresented: $showTags) {
                    TagView(item: item)
                }
                Spacer( )
                //MARK:  UPDATE BUTTON
                       NavigationLink {
                    NotesListView()
                } label: {
                    let count = item.notes?.count ?? 0
                    Label("\(count) Notes", systemImage: "square.and.pencil").fontDesign(.serif)
                }/// NOTES BUTTON FONT SIZE AND COLOR ADJUSTMENTS
                .fontDesign(.serif)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundStyle(.blue)
                .background(.thinMaterial.shadow(.drop(color: .black.opacity(0.95), radius: 4)), in: .rect(cornerRadius: 10))
                Spacer( )
            }.padding(3)
            .background(.thinMaterial.shadow(.drop(color: .black.opacity(0.55), radius: 4)), in: .rect(cornerRadius: 10))
            .buttonStyle(.bordered)
                .padding(.horizontal, 7)
           
        }
        .padding(.top, 15)
    }
    
}



