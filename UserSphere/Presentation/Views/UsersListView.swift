//
//  UsersListView.swift
//  UserSphere

import SwiftUI

struct UsersListView<VM: UsersViewModelProtocol>: View {
    @ObservedObject var viewModel: VM
    
    init(viewModel: VM) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                contentView
            }
            .navigationTitle(UserConstants.NavigationTitles.userListing.rawValue)
            .onAppear {
                // Only load users if they are not already loaded
                if viewModel.users.isEmpty {
                    viewModel.loadUsers()
                }
            }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        // Show loading indicator while fetching data
        if viewModel.isLoading && viewModel.users.isEmpty {
            loadingView
        }
        // Show error message if there is an error
        else if let errorMessage = viewModel.errorMessage {
            errorView(errorMessage: errorMessage)
        }
        // Show a message if no users are found
        else if viewModel.users.isEmpty {
            emptyStateView
        }
        // Show list of users if data is available
        else {
            userListView
        }
    }
    
    // MARK: - Views
    private var loadingView: some View {
        ProgressView(UserConstants.ErrorMessages.loading.rawValue)
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 20)
    }
    
    private func errorView(errorMessage: String) -> some View {
        VStack {
            Text(UserConstants.ErrorMessages.errorPrefix.rawValue + errorMessage)
                .font(.headline)
                .foregroundColor(.red)
                .padding()
            Button(UserConstants.ButtonTitles.retry.rawValue) {
                viewModel.loadUsers()
            }
            .foregroundColor(.blue)
        }
    }
    
    private var emptyStateView: some View {
        Text(UserConstants.ErrorMessages.noUsersAvailable.rawValue)
            .font(.title3)
            .foregroundColor(.gray)
            .padding()
    }
    
    private var userListView: some View {
        List(viewModel.users) { user in
            UserRowView(user: user)
                .background(
                    NavigationLink("", destination: UserDetailView(user: user))
                        .opacity(0)
                )
                .listRowBackground(Color.clear)
                .buttonStyle(PlainButtonStyle())
        }
        .listStyle(PlainListStyle())
        .listRowInsets(EdgeInsets())
    }
}

