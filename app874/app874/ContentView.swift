//
//  ContentView.swift
//  app874
//
//  Created by Dias Atudinov on 03.09.2024.
//

import SwiftUI

struct Service1: Identifiable, Codable {
    var id = UUID()
    var name: String
    var price: String
    var date: Date
    var notes: String
    
    var isExpired: Bool {
        date < Date()
    }
}

class ServiceViewModel: ObservableObject {
    @Published var services: [Service1] = []
    @Published var history: [Service1] = []
    
    func addService(name: String, price: String, date: Date, notes: String) {
        let service = Service1(name: name, price: price, date: date, notes: notes)
        if service.isExpired {
            history.append(service)
        } else {
            services.append(service)
        }
    }
    
    func checkExpiredServices() {
        let now = Date()
        services = services.filter { service in
            if service.date < now {
                history.append(service)
                return false
            }
            return true
        }
    }
}

struct AddServiceView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var serviceVM: ServiceViewModel
    
    @State private var name: String = ""
    @State private var price: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @State private var notes: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Service Details")) {
                    TextField("Name", text: $name)
                    TextField("Price", text: $price)
                    
                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                    
                    DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    
                    TextField("Notes", text: $notes)
                }
                
                Button(action: {
                    let combinedDateTime = combineDateAndTime(date: selectedDate, time: selectedTime)
                    serviceVM.addService(name: name, price: price, date: combinedDateTime, notes: notes)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Service")
                }
            }
            .navigationBarTitle("Add New Service", displayMode: .inline)
        }
    }
    
    private func combineDateAndTime(date: Date, time: Date) -> Date {
        let calendar = Calendar.current
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        var combinedComponents = DateComponents()
        combinedComponents.year = dateComponents.year
        combinedComponents.month = dateComponents.month
        combinedComponents.day = dateComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        
        return calendar.date(from: combinedComponents) ?? Date()
    }
}

struct ContentView: View {
    @ObservedObject var serviceVM = ServiceViewModel()
    @State private var showingAddServiceView = false
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Services")) {
                    ForEach(serviceVM.services) { service in
                        ServiceRow(service: service)
                    }
                }
                
                Section(header: Text("History")) {
                    ForEach(serviceVM.history) { service in
                        ServiceRow(service: service)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .onAppear {
                serviceVM.checkExpiredServices()
            }
            
            Button(action: {
                showingAddServiceView = true
            }) {
                Text("Add Service")
            }
            .sheet(isPresented: $showingAddServiceView) {
                AddServiceView(serviceVM: serviceVM)
            }
        }
    }
}

struct ServiceRow: View {
    var service: Service1
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(service.name)
                .font(.headline)
            Text(service.price)
            Text(service.date, style: .date)
            Text(service.notes)
        }
    }
}
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
#Preview {
    ContentView()
}
