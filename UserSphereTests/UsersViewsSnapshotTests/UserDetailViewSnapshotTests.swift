//
//  UserDetailViewSnapshotTests.swift
//  UserSphere
//
//  Created by Naresh Motwani 
//
import SnapshotTesting
import SwiftUI
import XCTest
@testable import UserSphere

// User Detail View Tests
class UserDetailViewSnapshotTests: XCTestCase {

    func testUserDetailViewWithUser() throws {
        let user = MockUserData.userWithImage
        let userDetailView = UserDetailView(user: user)
            .frame(width: 375, height: 600) // Set explicit frame size for the view
        // Test: UserDetailView for a user with image
        assertSnapshot(of: userDetailView, as: .image)
    }

    func testUserDetailViewWithUserWithoutImage() throws {
        // Assign a sample user without an image
        let userWithoutImage = MockUserData.sampleUser
        let userDetailView = UserDetailView(user: userWithoutImage)
            .frame(width: 375, height: 600) // Set explicit frame size for the view
        // Test: UserDetailView for a user without an image
        assertSnapshot(of: userDetailView, as: .image)
    }
}
