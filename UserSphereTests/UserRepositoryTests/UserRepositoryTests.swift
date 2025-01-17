//
//  UserRepositoryTests.swift
//  UserSphere
//

import XCTest
import Combine
@testable import UserSphere

class UserRepositoryTests: XCTestCase {
    var userRepository: MockUserRepository!
    var mockUserDataService: MockUserDataService!
    var userDataMapper: MapperProtocol!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        // Initialize the Mapper
        userDataMapper = UserDataMapper()
        // Initialize the MockUserDataService
        mockUserDataService = MockUserDataService(shouldFail: false)  // Default: success
        // Initialize the MockUserRepository with the mock service and the mapper
        userRepository = MockUserRepository(userDataService: mockUserDataService, userDataMapper: userDataMapper)
    }
    
    override func tearDown() {
        cancellables = []
        userRepository = nil
        mockUserDataService = nil
        userDataMapper = nil
        super.tearDown()
    }
    
    // MARK: - Success Test
    func testGetUsersSuccess() {
        let expectation = self.expectation(description: "Successfully fetches users")
        userRepository.getUsers()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but received error: \(error)")
                }
            }, receiveValue: { users in
                XCTAssertEqual(users.count, 2)
                XCTAssertEqual(users.first?.firstName, "Tester1")
                XCTAssertEqual(users.last?.firstName, "Tester2")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 5)
    }
    
    // MARK: - Failure Test
    func testGetUsersFailure() {
        let expectation = self.expectation(description: "Fails to fetch users")
        // Simulate failure by setting shouldFail to true
        mockUserDataService.shouldFail = true
        userRepository.getUsers()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual((error as NSError).domain, "TestError")
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but received success")
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 5)
    }
    
    // MARK: - Edge Case: Empty Users List
    func testGetUsersEmptyResponse() {
        let expectation = self.expectation(description: "Returns an empty list of users")
        // Set up empty user list
        mockUserDataService.mockResponse = UserResponseModel(users: [])
        userRepository.getUsers()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but received error: \(error)")
                }
            }, receiveValue: { users in
                // Verify that no users are returned
                XCTAssertEqual(users.count, 0)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 5)
    }
    
    // MARK: - Edge Case: Invalid User Data
    func testGetUsersInvalidData() {
        let expectation = self.expectation(description: "Handles invalid user data correctly")
        // Set the mock data to return the invalid user
        mockUserDataService.mockResponse = UserResponseModel(users: [UserData(id: 3, firstName: nil, lastName: "TestName1", email: nil, phone: "1234567890", age: 30, image: "https://example.com/invalid.jpg", address: nil)])
        userRepository.getUsers()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but received error: \(error)")
                }
            }, receiveValue: { users in
                XCTAssertEqual(users.count, 1)
                XCTAssertTrue(users.first?.firstName?.isEmpty == true) // Verify invalid firstName is handled
                expectation.fulfill()
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 5)
    }
}
