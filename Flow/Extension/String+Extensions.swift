//
//  String+Extensions.swift
//  Flow
//
//  Created by Joseph DeWeese on 2/4/25.
//

import Foundation

extension String {
    
    var isEmptyOrWhitespace: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

