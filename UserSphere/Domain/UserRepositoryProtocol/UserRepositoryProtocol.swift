//
//  UserRepositoryProtocol.swift
//  UserSphere
//
//  Created by Naresh Motwani
//
import Combine

protocol UserRepositoryProtocol {
    func getUsers() -> AnyPublisher<[User], Error>
}
