//
//  UserDataServiceTests.swift
//  UserSphere
//

import XCTest
import Combine
@testable import UserSphere

class UserDataServiceTests: XCTestCase {
    var userDataService: MockUserDataService!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        // Initialize the MockUserDataService
        userDataService = MockUserDataService(shouldFail: false) // Default to success
    }
    
    override func tearDown() {
        cancellables = []
        userDataService = nil
        super.tearDown()
    }
    
    // MARK: - Success Test
    func testGetUserDataSuccess() {
        let expectation = self.expectation(description: "User data fetched successfully")
        // Setup mock response for success
        let mockUserData = UserResponseModel(users: [
            UserData(id: 1, firstName: "Tester1", lastName: "TestName1", email: "tester1@example.com", phone: "1234567890", age: 30, image: "https://example.com/tester.jpg", address: nil)
        ])
        // Assign mock response to the service
        userDataService.mockResponse = mockUserData
        // Simulate the API request
        userDataService.getUserData(apiRequest: APIRequest(baseURL: UserConstants.APIBaseURL.userAPI.rawValue, method: .GET, endpoint: .userData))
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but received error: \(error)")
                }
            }, receiveValue: { response in
                XCTAssertEqual(response.users.count, 1)
                XCTAssertEqual(response.users.first?.firstName, "Tester1")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Failure Test
    func testGetUserDataFailure() {
        let expectation = self.expectation(description: "Fails to fetch user data")
        // Simulate failure by setting shouldFail to true
        userDataService.shouldFail = true
        // Simulate the API request that will fail
        userDataService.getUserData(apiRequest: APIRequest(baseURL: UserConstants.APIBaseURL.userAPI.rawValue, method: .GET, endpoint: .userData))
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual((error as NSError).domain, "TestError")
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but received success")
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Edge Case: No Users
    func testGetUserDataEmptyResponse() {
        let expectation = self.expectation(description: "Handles empty user data correctly")
        // Setup empty response
        let emptyResponse = UserResponseModel(users: [])
        userDataService.mockResponse = emptyResponse
        userDataService.getUserData(apiRequest: APIRequest(baseURL: UserConstants.APIBaseURL.userAPI.rawValue, method: .GET, endpoint: .userData))
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but received error: \(error)")
                }
            }, receiveValue: { response in
                XCTAssertEqual(response.users.count, 0) // Verify no users are returned
                expectation.fulfill()
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 5, handler: nil)
    }

    // MARK: - Edge Case: Invalid User Data (e.g., nil fields)
    func testGetUserDataInvalidUserData() {
        let expectation = self.expectation(description: "Handles invalid user data correctly")
        // Simulate invalid user data (e.g., missing firstName)
        let invalidUser = UserData(id: 2, firstName: nil, lastName: "TestName2", email: "invalid@example.com", phone: "0987654321", age: 28, image: "https://example.com/invalid.jpg", address: nil)
        let invalidResponse = UserResponseModel(users: [invalidUser])
        // Set the mock response with invalid user data
        userDataService.mockResponse = invalidResponse
        userDataService.getUserData(apiRequest: APIRequest(baseURL: UserConstants.APIBaseURL.userAPI.rawValue, method: .GET, endpoint: .userData))
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but received error: \(error)")
                }
            }, receiveValue: { response in
                XCTAssertEqual(response.users.count, 1)
                XCTAssertNil(response.users.first?.firstName) // Check that firstName is nil
                expectation.fulfill()
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 5, handler: nil)
    }
}
