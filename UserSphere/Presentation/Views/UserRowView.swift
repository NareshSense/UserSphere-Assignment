//
//  UserRowView.swift
//  UserSphere

import SwiftUI

struct UserRowView: View {
    var user: User
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            // Profile Image
            profileImageView
            // User's name and email
            userInfo
            // Chevron icon to indicate navigation
            chevronIcon
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5, y: 2)
        .contentShape(Rectangle()) // Makes the entire row tappable
    }
    
    // MARK: - Profile Image View
    @ViewBuilder
    private var profileImageView: some View {
        if let imageUrlString = user.image, let imageUrl = URL(string: imageUrlString) {
            AsyncImageWithCache(url: imageUrl)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
        } else {
            Image(systemName: UserConstants.ImageIcons.defaultPersonImage.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.gray)
                .padding(10)
        }
    }
    
    // MARK: - User Info (Name and Email)
    @ViewBuilder
    private var userInfo: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\(user.firstName ?? "") \(user.lastName ?? "")")
                .font(.headline)
                .foregroundColor(.primary)
            
            if let email = user.email, !email.isEmpty {
                Text(email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Chevron Icon
    private var chevronIcon: some View {
        Image(systemName: UserConstants.ImageIcons.rightChevron.rawValue)
            .foregroundColor(.gray)
            .padding(.trailing, 12)
    }
}

