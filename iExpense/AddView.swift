//
//  AddView.swift
//  iExpense
//
//  Created by Rob Ranf on 4/25/23.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var category = "Personal"
    @State private var amount = 0.0
    @ObservedObject var expenses: Expenses
    
    let expenseCategories = ["Business", "Personal"]
        
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Category", selection: $category) {
                    ForEach(expenseCategories, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add a new expense")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
