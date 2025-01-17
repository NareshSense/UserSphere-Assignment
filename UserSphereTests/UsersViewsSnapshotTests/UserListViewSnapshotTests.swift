//
//  UserListViewSnapshotTests.swift
//  UserSphere
//
//  Created by Naresh Motwani 
//

import SnapshotTesting
import SwiftUI
import XCTest
@testable import UserSphere

class UsersListViewSnapshotTests: XCTestCase {

    var mockViewModel: MockUsersViewModel!
    
    override func setUp() {
        super.setUp()
        mockViewModel = MockUsersViewModel()
    }
    
    override func tearDown() {
        mockViewModel = nil
    }
    
    // Test: Loading State
    func testLoadingState() throws {
        mockViewModel.isLoading = true
        let usersListViewLoading = UsersListView(viewModel: mockViewModel)
            .frame(width: 300, height: 300) // Set explicit frame size for the view
        assertSnapshot(of: usersListViewLoading, as: .image)
    }
    
    // Test: Error State
    func testErrorState() throws {
        mockViewModel.isLoading = false
        mockViewModel.errorMessage = "Failed to load users"
        let usersListViewError = UsersListView(viewModel: mockViewModel)
            .frame(width: 402, height: 874) // Set explicit frame size for the view

        assertSnapshot(of: usersListViewError, as: .image)
    }
    
    // Test: Empty State
    func testEmptyState() throws {
        mockViewModel.errorMessage = nil
        mockViewModel.users = []  // Empty user list
        let usersListViewEmpty = UsersListView(viewModel: mockViewModel)
            .frame(width: 300, height: 300) // Set explicit frame size for the view
        assertSnapshot(of: usersListViewEmpty, as: .image)
    }
    
    // Test: Populated State
    func testUsersListView() throws {
        mockViewModel.users = MockUserData.sampleUsers  // Assigning mock users
        let usersListViewPopulated = UsersListView(viewModel: mockViewModel)
            .frame(width: 402, height: 874) // Set explicit frame size for the view
        assertSnapshot(of: usersListViewPopulated, as: .image)
    }
}
