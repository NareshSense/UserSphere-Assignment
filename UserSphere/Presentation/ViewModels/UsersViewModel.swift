//
//  UsersViewModel.swift
//  UserSphere

import Combine
import Foundation

final class UsersViewModel: UsersViewModelProtocol {
    
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let getUsersUseCase: GetUsersUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(getUsersUseCase: GetUsersUseCaseProtocol) {
        self.getUsersUseCase = getUsersUseCase
    }
    
    // Ensures UI updates happen on the main thread
    func loadUsers() {
        // Start loading process
        Task { @MainActor in
            isLoading = true
            errorMessage = nil  // Reset error message
        }
        getUsersUseCase.execute()  // Fetch users using the use case
            .receive(on: DispatchQueue.main) // Ensure that UI updates happen on the main thread
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false  // Hide loading indicator when the request finishes
                
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription  // Update error message on failure
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] users in
                // Update users list on success
                self?.users = users
            })
            .store(in: &cancellables)
    }
}

