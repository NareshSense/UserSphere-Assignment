//
//  MockUserData.swift
//  UserSphere
//
//  Created by Naresh Motwani
//

@testable import UserSphere

// MARK: - Mock Users Data
struct MockUserData {
    static let sampleUser = User(id: 1, firstName: "John", lastName: "Doe", email: "john.doe@example.com", phone: "123-456-7890", age: 30, image: nil, address: "1234 Elm Street", country: "USA")
    
    static let userWithImage = User(id: 1, firstName: "John", lastName: "Doe", email: "john.doe@example.com", phone: "123-456-7890", age: 30, image: "https:example.com", address: "1234 Elm Street", country: "USA")
    
    static let sampleUsers: [User] = [
        User(id: 1, firstName: "John", lastName: "Doe", email: "john.doe@example.com", phone: "123-456-7890", age: 30, image: nil, address: "1234 Elm Street", country: "USA"),
        User(id: 2, firstName: "Jane", lastName: "Smith", email: "jane.smith@example.com", phone: "987-654-3210", age: 25, image: nil, address: "5678 Oak Street", country: "Canada"),
        User(id: 3, firstName: "Bob", lastName: "Johnson", email: "bob.johnson@example.com", phone: "555-123-4567", age: 40, image: nil, address: "9101 Pine Street", country: "UK")
    ]
}
