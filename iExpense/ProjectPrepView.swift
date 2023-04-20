//
//  ContentView.swift
//  iExpense
//
//  Created by Rob Ranf on 4/17/23.
//

import SwiftUI

struct ProjectPrepView: View {
    // Note: when creating the shared data use @StateObject, but when you’re just using it in a
    // different view you should use @ObservedObject instead.
    @StateObject var user = User()
    @State private var showingSheet = false
    @State private var showingNumberView = false
    @State private var showingUserDefaults = false
    
    @State private var madison = UserTwo(firstName: "Madison", lastName: "Ranf")
    
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "Madison")
        }
        
        Spacer()
        
        Button("Show Number View") {
            showingNumberView.toggle()
        }
        .sheet(isPresented: $showingNumberView) {
            NumberView()
        }
        
        Spacer()
        
        Button("Show User Defaults View") {
            showingUserDefaults.toggle()
        }
        .sheet(isPresented: $showingUserDefaults) {
            UserDefaultsView()
        }
        
        Spacer()
        
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
            
            Button("Save User") {
                let encoder = JSONEncoder()
                if let data = try? encoder.encode(madison) {
                    UserDefaults.standard.set(data, forKey: "UserDate")
                }
            }
        }
        .padding()
    }
}

struct SecondView: View {
    let name: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("Hello, \(name)")
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct NumberView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    // On delete presents the red delete button on swipe from right to left
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct UserDefaultsView: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            // Use a built-in standard istance of UserDefaults
            // but can also build own instances. We're calling the key here "Tap", which
            // has no special meaning, but we need to use that exact name when
            // reading the data out of UserDefaults
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
        }
    }
}

struct UserTwo: Codable {
    let firstName: String
    let lastName: String
}

// Because @State only works on structs for internal struct state, we need to use the
// @Published property observer in addition to the @StateObject property wrapper to
// pass state around views vs just inside a struct.

// @Published functions in a way like half of how @State functions, it tells Swift that
// whenever the property changes, it should broadcast that change to any SwiftUI views
// that are watching so they should reload. The other half, the part that says which
// instantiated object should be watched, is wrapped using @StateObject.

// Passing ObservableObject as an inherited type alias makes the class conform to the
// ObservableObject protocol, which is required to use @StateObject when we
// instantiate the class above.
class User: ObservableObject {
    @Published var firstName = "Madison"
    @Published var lastName = "Ranf"
}

struct ProjectPrepView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPrepView()
    }
}
