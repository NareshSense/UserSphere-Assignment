//
//  MockUserRepository.swift
//  UserSphere
//


import Combine
import Foundation
@testable import UserSphere

// MARK: - Mock User Repository
class MockUserRepository: UserRepositoryProtocol {
    private var userDataService: MockUserDataService
    private var userDataMapper: MapperProtocol
    
    // Initialize with the mock data service and mapper
    init(userDataService: MockUserDataService, userDataMapper: MapperProtocol) {
        self.userDataService = userDataService
        self.userDataMapper = userDataMapper
    }
    
    // Function to get users from the mock service
    func getUsers() -> AnyPublisher<[User], Error> {
        return userDataService.getUserData(apiRequest: APIRequest(baseURL: UserConstants.APIBaseURL.userAPI.rawValue, method: .GET, endpoint: .userData))
            .map { response in
                return response.users.map { self.userDataMapper.dtoToDomain(userData: $0) }
            }
            .eraseToAnyPublisher()
    }
}

