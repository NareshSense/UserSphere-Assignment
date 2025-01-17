//
//  UserData.swift
//  UserSphere

struct UserData: Codable, Identifiable {
    let id: Int
    let firstName: String?
    let lastName: String?
    let email: String?
    let phone: String?
    let age: Int
    let image: String?
    let address: AddressData?
}

struct AddressData: Codable {
    let address: String?
    let city: String?
    let state: String?
    let country: String?
}
