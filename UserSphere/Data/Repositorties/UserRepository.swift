//
//  UserRepository.swift
//  UserSphere

import Foundation
import Combine

final class UserRepository: UserRepositoryProtocol {
    private let userDataService: UserDataServiceProtocol
    private let mapper: MapperProtocol
    var cache: ImageCache?

    init(userDataService: UserDataServiceProtocol, mapper: MapperProtocol, cache: ImageCache = ImageCache()) {
        self.userDataService = userDataService
        self.mapper = mapper
        self.cache = cache
    }
    
    func getUsers() -> AnyPublisher<[User], Error> {
        let apiRequest = APIRequest(baseURL: UserConstants.APIBaseURL.userAPI.rawValue, method: .GET, endpoint: .userData)
        
        return userDataService.getUserData(apiRequest: apiRequest)
            .map { userDataArray in
                userDataArray.users.map { self.mapper.dtoToDomain(userData: $0) }
            }
            .eraseToAnyPublisher()
    }
}

