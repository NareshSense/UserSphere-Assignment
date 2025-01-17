//
//  MockUsersUseCase.swift
//  UserSphere
//
//

import Combine
import Foundation
@testable import UserSphere

// MARK: - Mock Get Users Use Case
class MockGetUsersUseCase: GetUsersUseCaseProtocol {
    var userRepository: UserRepositoryProtocol
    var shouldFail: Bool
    
    // Initialization with the user repository
    init(userRepository: UserRepositoryProtocol, shouldFail: Bool = false) {
        self.userRepository = userRepository
        self.shouldFail = shouldFail
    }
    
    func execute() -> AnyPublisher<[User], Error> {
        if shouldFail {
            // Simulate failure (for test purposes) by returning an error
            return Fail(error: NSError(domain: "TestError", code: 0, userInfo: nil))
                .eraseToAnyPublisher()
        } else {
            // Simulate success by calling the repository to get users
            return userRepository.getUsers()
        }
    }
}


