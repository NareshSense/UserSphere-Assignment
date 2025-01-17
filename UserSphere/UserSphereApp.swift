//
//  UserSphereApp.swift
//  UserSphere
//
//  Created by Naresh Motwani 
//

import SwiftUI

@main
struct UserSphereApp: App {
    
    var body: some Scene {
        WindowGroup {
            let networkClient = NetworkClient()
            let userDataService = UserDataService(networkClient: networkClient)  // Service
            let userDataMapper = UserDataMapper()  // Mapper
            let userRepository = UserRepository(userDataService: userDataService, mapper: userDataMapper)
            let getUsersUseCase = GetUserUseCase(userRepository: userRepository)
            // Initialize the ViewModel
            let usersViewModel = UsersViewModel(getUsersUseCase: getUsersUseCase)
            // Pass the ViewModel into the View
            UsersListView(viewModel: usersViewModel)
        }
    }
}

