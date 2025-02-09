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
        HStack(spacing: 5) {
            ForEach(Category.allCases, id: \.rawValue) { category in
               VStack(spacing: 5) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundStyle(.blue)
                        
                        if self.category == category {
                            Image(systemName: "circle.fill")
                                .font(.callout)
                                .foregroundStyle(.orange)
                        }
                    }
                    Text(category.rawValue)
                        .font(.caption)
                        .fontDesign(.serif)
                }
               .padding(5)
                .contentShape(.rect)
                .onTapGesture {
                    self.category = category
                }
            }
        }
        .padding(.vertical, 2)
        .background(.gray.opacity(0.2), in: .rect(cornerRadius: 7))
        .overlay(
            RoundedRectangle(cornerRadius: 7)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
    
    /// Number Formatter
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
}
