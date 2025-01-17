//
//  UserRowViewTests.swift
//  UserSphere
//
//  Created by Naresh Motwani
//
import XCTest
import SwiftUI
import ViewInspector
@testable import UserSphere

class UserRowViewTests: XCTestCase {

    var user: User!
    var userRowView: UserRowView!

    override func setUp() {
        super.setUp()
        user = MockUserData.sampleUser
        userRowView = UserRowView(user: user)
    }

    override func tearDown() {
        user = nil
        userRowView = nil
        super.tearDown()
    }

    func testUserRowViewDisplaysUserName() throws {
        let view = try userRowView.inspect()
        let userNameText = try view.find(text: (user.firstName ?? "") + " " + (user.lastName ?? "")).string()
        XCTAssertEqual(userNameText, "John Doe")
    }

    func testUserRowViewDisplaysUserEmail() throws {
        let view = try userRowView.inspect()
        let userEmailText = try view.find(text: user.email ?? "").string()
        XCTAssertEqual(userEmailText, "john.doe@example.com")
    }

    func testUserRowViewDisplaysProfileImage() throws {
        let view = try userRowView.inspect()
        let imageView = view.findAll(AsyncImageWithCache.self)
        XCTAssertNotNil(imageView)
    }

}
