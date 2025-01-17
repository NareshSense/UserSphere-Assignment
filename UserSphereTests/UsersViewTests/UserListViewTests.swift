//
//  UserListViewTests.swift
//  UserSphere
//
//  Created by Naresh Motwani 
//
import XCTest
import SwiftUI
import ViewInspector
@testable import UserSphere

class UsersListViewTests: XCTestCase {

    var mockViewModel: MockUsersViewModel!
    var usersListView: UsersListView<MockUsersViewModel>!

    override func setUp() {
        super.setUp()
        mockViewModel = MockUsersViewModel()
        mockViewModel.users = MockUserData.sampleUsers
        usersListView = UsersListView(viewModel: mockViewModel)
    }

    override func tearDown() {
        mockViewModel = nil
        usersListView = nil
        super.tearDown()
    }

    func testUsersListViewShowsUsers() throws {
        let view = try usersListView.inspect()
        let rows = view.findAll(UserRowView.self)  // Find all the rows
        XCTAssertEqual(rows.count, 3)  // We should have 3 rows (users)
    }

    func testUsersListHasNoRowsEmptyState() throws {
        mockViewModel.users = []
        let view = try usersListView.inspect()
        let rows = view.findAll(UserRowView.self)  // Find all the rows
        XCTAssertEqual(rows.count, 0)
    }
}
