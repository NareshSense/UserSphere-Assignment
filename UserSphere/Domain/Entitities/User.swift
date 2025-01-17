//
//  User.swift
//  UserSphere

import Foundation

// User Entity
struct User: Codable, Identifiable {
    let id: Int
    let firstName: String?
    let lastName: String?
    let email: String?
    let phone: String?
    let age: Int
    let image: String?
    let address: String?
    let country: String?
}


