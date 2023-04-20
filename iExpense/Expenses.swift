//
//  Expenses.swift
//  iExpense
//
//  Created by Rob Ranf on 4/19/23.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
