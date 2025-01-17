//
//  UserDataService.swift
//  UserSphere

import Combine

// MARK: - UserDataService Protocol
protocol UserDataServiceProtocol {
    func getUserData(apiRequest: APIRequest) -> AnyPublisher<UserResponseModel, Error>
}

// MARK: - UserDataService Implementation
final class UserDataService: UserDataServiceProtocol {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func getUserData(apiRequest: APIRequest) -> AnyPublisher< UserResponseModel, Error> {
        return networkClient.request(apiRequest: apiRequest)
    }
}

