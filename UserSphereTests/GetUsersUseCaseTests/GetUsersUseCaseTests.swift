//
//  GetUsersUseCaseTests.swift
//  UserSphere
//
//

import XCTest
import Combine
@testable import UserSphere

class GetUserUseCaseTests: XCTestCase {
    var useCase: GetUserUseCase!
    var cancellables: Set<AnyCancellable> = []
    var mockUserRepository: MockUserRepository!
    var mockUserDataService: MockUserDataService!
    
    override func setUp() {
        super.setUp()
        // Initialize mock data service and repository
        mockUserDataService = MockUserDataService(shouldFail: false)
        let mockUserDataMapper = UserDataMapper() // Mapper
        // Mock repository using mock data service and mapper
        mockUserRepository = MockUserRepository(userDataService: mockUserDataService, userDataMapper: mockUserDataMapper)
        // Initialize the use case with the mock repository
        useCase = GetUserUseCase(userRepository: mockUserRepository)
    }
    
    override func tearDown() {
        cancellables = []
        useCase = nil
        mockUserRepository = nil
        mockUserDataService = nil
        super.tearDown()
    }
    
    // MARK: - Success Test
    func testExecuteSuccess() {
        let expectation = self.expectation(description: "Successfully fetches users from use case")
        // Mock the response in the service
        let mockUserData = UserResponseModel(users: [
            UserData(id: 1, firstName: "Tester1", lastName: "TestName1", email: "tester1.doe@example.com", phone: "1234567890", age: 30, image: "https://example.com/tester1.jpg", address: nil)
        ])
        mockUserDataService.mockResponse = mockUserData
        useCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but received error: \(error)")
                }
            }, receiveValue: { users in
                // Verify the mock users are returned
                XCTAssertEqual(users.count, 1)
                XCTAssertEqual(users.first?.firstName, "Tester1")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 5)
    }
    
    // MARK: - Failure Test
    func testExecuteFailure() {
        let expectation = self.expectation(description: "Fails to fetch users from use case")
        // Simulate failure by setting shouldFail to true
        mockUserDataService.shouldFail = true
        useCase.execute()
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
    func testExecuteEmptyUsers() {
        let expectation = self.expectation(description: "Returns an empty list of users from use case")
        // Setup empty response
        let emptyResponse = UserResponseModel(users: [])
        mockUserDataService.mockResponse = emptyResponse
        useCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but received error: \(error)")
                }
            }, receiveValue: { users in
                // Verify no users are returned
                XCTAssertEqual(users.count, 0)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 5)
    }
    
    // MARK: - Edge Case: Invalid Data
    func testExecuteInvalidData() {
        let expectation = self.expectation(description: "Handles invalid user data correctly")
        // Simulate invalid user data (e.g., missing fields)
        let invalidUser = UserData(id: 3, firstName: nil, lastName: "Doe", email: nil, phone: "1234567890", age: 30, image: "https://example.com/invalid.jpg", address: nil)
        let invalidResponse = UserResponseModel(users: [invalidUser])
        // Set the mock response with invalid user data
        mockUserDataService.mockResponse = invalidResponse
        useCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but received error: \(error)")
                }
            }, receiveValue: { users in
                XCTAssertEqual(users.count, 1)
                XCTAssertTrue(users.first?.firstName?.isEmpty == true) // Check that firstName is empty for nil
                expectation.fulfill()
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 5)
    }
}
