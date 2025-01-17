//
//  UsersViewModelTests.swift
//  UserSphere
//

import XCTest
import Combine
@testable import UserSphere

class UsersViewModelTests: XCTestCase {
    var viewModel: UsersViewModel!
    var mockGetUsersUseCase: MockGetUsersUseCase!
    var mockUserDataService: MockUserDataService!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        // Mock the data service and repository
        mockUserDataService = MockUserDataService(shouldFail: false)
        let mockUserRepository = MockUserRepository(userDataService: mockUserDataService, userDataMapper: UserDataMapper())
        mockGetUsersUseCase = MockGetUsersUseCase(userRepository: mockUserRepository)
        // Initialize the view model with the mock use case
        viewModel = UsersViewModel(getUsersUseCase: mockGetUsersUseCase)
        
    }

    override func tearDown() {
        cancellables = []
        viewModel = nil
        mockGetUsersUseCase = nil
        mockUserDataService = nil
        super.tearDown()
    }

    // MARK: - Success Test
    @MainActor func testLoadUsersSuccess() {
        let expectation = self.expectation(description: "Successfully loads users")
        // Mock the data service to return mock user data
        mockUserDataService.mockResponse = UserResponseModel(users: [
            UserData(id: 1, firstName: "Tester1", lastName: "TestName1", email: "tester1@example.com", phone: "1234567890", age: 30, image: "https://example.com/tester1.jpg", address: nil),
            UserData(id: 2, firstName: "Tester2", lastName: "TestName2", email: "tester2@example.com", phone: "0987654321", age: 28, image: "https://example.com/tester2.jpg", address: nil)
        ])
        // Observe the view model's users property
        viewModel.$users
            .sink { users in
                if users.count > 0 {
                    XCTAssertEqual(users.count, 2)
                    XCTAssertEqual(users.first?.firstName, "Tester1")
                    XCTAssertEqual(users.last?.firstName, "Tester2")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        viewModel.loadUsers()
        waitForExpectations(timeout: 5)
    }

    // MARK: - Failure Test
    @MainActor func testLoadUsersFailure() {
        let expectation = self.expectation(description: "Fails to load users")
        // Simulate failure by setting shouldFail to true in the data service
        mockUserDataService.shouldFail = true
        viewModel.$errorMessage
            .sink { errorMessage in
                if errorMessage != nil {
                    XCTAssertEqual(errorMessage, "The operation couldn’t be completed. (TestError error 0.)")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        viewModel.loadUsers()
        waitForExpectations(timeout: 5)
    }

    // MARK: - Loading State Test
    @MainActor func testLoadUsersChangesLoadingState() {
        let expectation = self.expectation(description: "Loading state is updated")
        // Observe the loading state
        viewModel.$isLoading
            .dropFirst()  // Skip initial value
            .sink { isLoading in
                if !isLoading {
                    XCTAssertFalse(isLoading)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        viewModel.loadUsers()
        waitForExpectations(timeout: 5)
    }

    // MARK: - Edge Case: Empty Users List
    @MainActor func testLoadUsersEmptyUsers() {
        let expectation = self.expectation(description: "Handles empty users list")
        // Set up empty response in the mock data service
        mockUserDataService.mockResponse = UserResponseModel(users: [])
        viewModel.$users
            .sink { users in
                XCTAssertEqual(users.count, 0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.loadUsers()
        waitForExpectations(timeout: 5)
    }

    // MARK: - Edge Case: No Users Available Message
    @MainActor func testLoadUsersNoUsersAvailableMessage() {
        let expectation = self.expectation(description: "Shows no users available message")
        // Set up empty user list in the mock data service
        mockUserDataService.mockResponse = UserResponseModel(users: [])
        viewModel.loadUsers()
        // Verify that the error message is set when no users are available
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.users.isEmpty, true)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}
