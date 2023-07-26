//
//  Prospect.swift
//  Hot Prospects
//
//  Created by Radu Petrisel on 25.07.2023.
//

import SwiftUI

final class Prospect: Identifiable, Codable {
    var id = UUID()
    
    var name = "Anonymous"
    var email = ""
    fileprivate(set) var isContacted = false
}

@MainActor final class Prospects: ObservableObject {
    private static let peopleFile = "people.json"
    @Published private(set) var people: [Prospect]
    
    init() {
        if let data = try? Data(contentsOf: FileManager.documentsDirectory.appending(component: Self.peopleFile)) {
            if let people = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = people
                return
            }
        }
        
        people = []
    }
    
    func append(prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            let peopleFile = FileManager.documentsDirectory.appending(path: Self.peopleFile)
            try? encoded.write(to: peopleFile, options: [.atomic, .completeFileProtection])
        }
    }
}
