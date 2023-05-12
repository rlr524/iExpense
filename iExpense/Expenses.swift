//
//  Expenses.swift
//  iExpense
//
//  Created by Rob Ranf on 4/19/23.
//

import Foundation

class Expenses: ObservableObject {
    var personalItems: [ExpenseItem] {
        // In this usage, because an array of ExpenseItem objects is being filtered, the
        // $0 just means "the item that is currently being looked at by the filter function"
        items.filter { $0.category == "Personal" }
    }
    
    var businessItems: [ExpenseItem] {
        items.filter { $0.category == "Business" }
    }
    
    // @Published announces changes from a property
    // @ObservedObject (the wrapper on the expenses object created using this class)
    // watches that object for changes
    @Published var items = [ExpenseItem]() {
        didSet {
            // Create an encoder and use it to encode the array of ExpenseItem objects
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            // Use .self to be clear referring to the type itself, the type object
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
