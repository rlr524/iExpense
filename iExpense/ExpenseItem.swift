//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Rob Ranf on 4/19/23.
//

import Foundation

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
