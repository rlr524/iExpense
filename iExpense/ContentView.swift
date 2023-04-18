//
//  ContentView.swift
//  iExpense
//
//  Created by Rob Ranf on 4/17/23.
//

import SwiftUI

struct ContentView: View {
    // Note: when creating the shared data use @StateObject, but when you’re just using it in a
    // different view you should use @ObservedObject instead.
    @StateObject var user = User()
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
        .padding()
    }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
