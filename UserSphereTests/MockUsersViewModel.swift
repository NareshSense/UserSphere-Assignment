//
//  MockUsersViewModel.swift
//  UserSphere
//
//  Created by Naresh Motwani
//

@testable import UserSphere
import Combine

// Mock ViewModel
class MockUsersViewModel: UsersViewModelProtocol {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    func loadUsers() {
        // Simulate loading users with mock data
        users = MockUserData.sampleUsers
        isLoading = false
    }
}
