//
//  View-ExpenseStyle.swift
//  iExpense
//
//  Created by Rob Ranf on 5/11/23.
//

import SwiftUI

extension View {
    func style(for item: ExpenseItem) -> some View {
        if item.amount < 10 {
            return self.foregroundColor(.green)
        } else if item.amount < 100 {
            return self.foregroundColor(.purple)
        } else {
            return self.foregroundColor(.red)
        }
    }
}
