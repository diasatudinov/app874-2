//
//  ContentView.swift
//  app874
//
//  Created by Dias Atudinov on 03.09.2024.
//

import SwiftUI



struct ContentView: View {
    @State private var showAlert = false
       @State private var selectedAction: Action?

       enum Action {
           case edit
           case delete
       }

       var body: some View {
           VStack {
               Button(action: {
                   // This can be empty since the action is handled by the context menu
               }) {
                   Text("Tap Me")
                       .padding()
                       .background(Color.blue)
                       .foregroundColor(.white)
                       .cornerRadius(10)
               }
               .contextMenu {
                   Button(action: {
                       selectedAction = .edit
                       showAlert = true
                   }) {
                       Text("Edit")
                       Image(systemName: "pencil")
                   }

                   Button(action: {
                       selectedAction = .delete
                       showAlert = true
                   }) {
                       Text("Delete")
                       Image(systemName: "trash")
                   }
               }
               .alert(isPresented: $showAlert) {
                   if selectedAction == .edit {
                       return Alert(title: Text("Edit"), message: Text("You chose to edit."), dismissButton: .default(Text("OK")))
                   } else if selectedAction == .delete {
                       return Alert(title: Text("Delete"), message: Text("You chose to delete."), dismissButton: .destructive(Text("OK")))
                   } else {
                       return Alert(title: Text("Error"), message: Text("Something went wrong."), dismissButton: .default(Text("OK")))
                   }
               }
           }
           .padding()
       }
   }

#Preview {
    ContentView()
}
