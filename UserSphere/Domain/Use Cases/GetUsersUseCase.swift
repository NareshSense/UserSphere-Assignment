//
//  GetUserUseCase.swift
//  UserSphere

import Foundation
import Combine

protocol GetUsersUseCaseProtocol {
    func execute() -> AnyPublisher<[User], Error>
}

final class GetUserUseCase: GetUsersUseCaseProtocol {
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    func execute() -> AnyPublisher<[User], Error> {
        return userRepository.getUsers()
    }
}

