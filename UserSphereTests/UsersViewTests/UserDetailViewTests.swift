//
//  Untitled.swift
//  UserSphere
//
//  Created by Naresh Motwani
//

import XCTest
import SwiftUI
import ViewInspector
@testable import UserSphere


class UserDetailViewTests: XCTestCase {

    var user: User!
    var userDetailView: UserDetailView!

    override func setUp() {
        super.setUp()
        user = MockUserData.sampleUser
        userDetailView = UserDetailView(user: user)
    }

    override func tearDown() {
        user = nil
        userDetailView = nil
        super.tearDown()
    }

    func testUserDetailViewUserName() throws {
        let view = try userDetailView.inspect()
        let userNameText = try view.find(text: (user.firstName ?? "") + " " + (user.lastName ?? "")).string()
        XCTAssertEqual(userNameText, "John Doe")
    }

    func testUserDetailViewDisplaysUserEmail() throws {
        let view = try userDetailView.inspect()
        let userEmailText = try view.find(text: user.email ?? "").string()
        XCTAssertEqual(userEmailText, "john.doe@example.com")
    }

    func testUserDetailViewDisplaysUserPhone() throws {
        let view = try userDetailView.inspect()
        let phoneText = try view.find(text: user.phone ?? "").string()
        XCTAssertEqual(phoneText, "123-456-7890")
    }

    func testUserDetailViewDisplaysUserCountry() throws {
        let view = try userDetailView.inspect()
        let countryText = try view.find(text: user.country ?? "").string()
        XCTAssertEqual(countryText, "USA")
    }

    func testUserDetailViewProfileImage() throws {
        let view = try userDetailView.inspect()
        let imageView = view.findAll(AsyncImageWithCache.self)
        XCTAssertNotNil(imageView)
    }
}
