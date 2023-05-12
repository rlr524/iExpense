//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Rob Ranf on 4/19/23.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let category: String
    let amount: Double
}
