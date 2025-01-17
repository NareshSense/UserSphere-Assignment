//
//  UsersViewModelProtocol.swift
//  UserSphere
//
//  Created by Naresh Motwani
//

import Combine
import Foundation

protocol UsersViewModelProtocol: ObservableObject {
    var users: [User] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func loadUsers()
}
