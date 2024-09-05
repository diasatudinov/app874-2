//
//  ContentView.swift
//  app874
//
//  Created by Dias Atudinov on 03.09.2024.
//

import SwiftUI

struct Person: Identifiable {
    let id = UUID()
    var firstName: String
    var lastName: String
}

class PeopleViewModel: ObservableObject {
    @Published var people: [Person] = [
        Person(firstName: "John", lastName: "Doe"),
        Person(firstName: "Jane", lastName: "Smith"),
        Person(firstName: "Alice", lastName: "Johnson"),
        Person(firstName: "Bob", lastName: "Williams")
    ]
    
    @Published var selectedPeople: Set<UUID> = [] // Store selected people by their IDs
}
//struct ContentView: View {
//    // Массив всех участников
//    let participants = ["Иван Иванов", "Петр Петров", "Мария Сидорова", "Алексей Смирнов"]
//    
//    // Массив для отслеживания выбранных участников
//    @State private var selectedParticipants: [String] = []
//    
//    var body: some View {
//        VStack {
//            Text("Выбранные участники:")
//                .font(.headline)
//                .padding()
//            
//            // Список выбранных участников
//            List(selectedParticipants, id: \.self) { participant in
//                Text(participant)
//            }
//            .frame(height: 150) // Ограничение высоты списка выбранных участников
//            
//            Spacer()
//            
//            // Menu для выбора участников
//            Menu {
//                // Перебираем всех участников и создаем элементы меню с Toggle
//                ForEach(participants, id: \.self) { participant in
//                    Toggle(isOn: Binding(
//                        get: { selectedParticipants.contains(participant) },
//                        set: { isSelected in
//                            toggleSelection(for: participant, isSelected: isSelected)
//                        }
//                    )) {
//                        Text(participant)
//                    }
//                }
//            } label: {
//                Text("Выбрать участников")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//        }
//        .padding()
//    }
//    
//    // Функция для добавления/удаления участника из списка выбранных
//    func toggleSelection(for participant: String, isSelected: Bool) {
//        if isSelected {
//            selectedParticipants.append(participant)
//        } else {
//            selectedParticipants.removeAll { $0 == participant }
//        }
//    }
//}

struct ContentView: View {
    // Массив всех участников
    let participants = ["Иван Иванов", "Петр Петров", "Мария Сидорова", "Алексей Смирнов"]
    
    // Массив для отслеживания выбранных участников
    @State private var selectedParticipants: [String] = []
    
    var body: some View {
        VStack {
            Text("Выбранные участники:")
                .font(.headline)
                .padding()
            
            // Список выбранных участников
            List(selectedParticipants, id: \.self) { participant in
                Text(participant)
            }
            .frame(height: 150) // Ограничение высоты списка выбранных участников
            
            Spacer()
            
            // Menu для выбора участников
            Menu {
                // Перебираем всех участников и создаем элементы меню
                ForEach(participants, id: \.self) { participant in
                    Button(action: {
                        toggleSelection(for: participant)
                    }) {
                        HStack {
                            Text(participant)
                            Spacer()
                            // Отображаем галочку для выбранных участников
                            if selectedParticipants.contains(participant) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            } label: {
                Text("Выбрать участников")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
    
    // Функция для добавления/удаления участника из списка выбранных
    func toggleSelection(for participant: String) {
        if let index = selectedParticipants.firstIndex(of: participant) {
            selectedParticipants.remove(at: index)
        } else {
            selectedParticipants.append(participant)
        }
    }
}

struct MenuView: View {
    @ObservedObject var viewModel: PeopleViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.people) { person in
                HStack {
                    Text("\(person.firstName) \(person.lastName)")
                    Spacer()
                    
                    // Checkmark for selected items
                    if viewModel.selectedPeople.contains(person.id) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .onTapGesture {
                    toggleSelection(for: person)
                }
            }
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding()
    }
    
    private func toggleSelection(for person: Person) {
        if viewModel.selectedPeople.contains(person.id) {
            viewModel.selectedPeople.remove(person.id)
        } else {
            viewModel.selectedPeople.insert(person.id)
        }
    }
}

#Preview {
    ContentView()
}
