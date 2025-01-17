//
//  MockUserDataService.swift
//  UserSphere
//
//  Created by Naresh Motwani 
//

import Combine
import Foundation
@testable import UserSphere

// MARK: - Mock User Data Service
class MockUserDataService: UserDataServiceProtocol {
    var shouldFail: Bool
    var mockResponse: UserResponseModel
    
    // Initialization with failure flag and custom mock response
    init(shouldFail: Bool = false, mockResponse: UserResponseModel? = nil) {
        self.shouldFail = shouldFail
        self.mockResponse = mockResponse ?? UserResponseModel(users: [
            UserData(
                id: 1,
                firstName: "Tester1",
                lastName: "TestName1",
                email: "tester1@example.com",
                phone: "1234567890",
                age: 30,
                image: "https://example.com/tester1.jpg",
                address: nil
            ),
            UserData(
                id: 2,
                firstName: "Tester2",
                lastName: "TestName2",
                email: "tester2@example.com",
                phone: "0987654321",
                age: 28,
                image: "https://example.com/tester2.jpg",
                address: nil
            )
        ])
    }
    
    // Returns a publisher that either succeeds or fails based on `shouldFail`
    func getUserData(apiRequest: APIRequest) -> AnyPublisher<UserResponseModel, Error> {
        if shouldFail {
            // Simulate failure by returning an error
            return Fail(error: NSError(domain: "TestError", code: 0, userInfo: nil))
                .eraseToAnyPublisher()
        } else {
            // Return mock response as a successful publisher
            return Just(mockResponse)
                .setFailureType(to: Error.self)  // Explicitly set the failure type
                .eraseToAnyPublisher()
        }
    }
}
