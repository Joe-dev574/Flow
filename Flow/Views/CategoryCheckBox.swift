//
//  CategoryCheckBox.swift
//  Flow
//
//  Created by Joseph DeWeese on 2/1/25.
//

import SwiftUI
import SwiftData




struct CategoryCheckBox: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
  //  @State private var category: Category = .Wiki
    @Binding var category: Category
    
    var body: some View {
        HStack(spacing: 7) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                HStack(spacing: 3) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.caption)
                            .foregroundStyle(.blue)
                        
                        if self.category == category {
                            Image(systemName: "circle.fill")
                                .font(.caption2)
                                .foregroundStyle(.orange)
                        }
                    }
                    Text(category.rawValue)
                        .font(.caption)
                        .fontDesign(.serif)
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.category = category
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        //        .hSpacing(.center)
        .background(.gray.opacity(0.2), in: .rect(cornerRadius: 10))
    }
    
    /// Number Formatter
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
}
