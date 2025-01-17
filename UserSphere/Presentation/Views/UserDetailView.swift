//
//  UserDetailView.swift
//  UserSphere

import SwiftUI

struct UserDetailView: View {
    let user: User
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Profile Image
                profileImage
                // User Name
                userName
                // User Details
                userDetails
                // Address Section
                addressSection
                Spacer()
            }
            .padding()
        }
        .navigationTitle(UserConstants.NavigationTitles.userDetail.rawValue)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Profile Image
    @ViewBuilder
    private var profileImage: some View {
        if let imageUrlString = user.image, let imageUrl = URL(string: imageUrlString) {
            AsyncImageWithCache(url: imageUrl)
                .frame(width: 300, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 150))
                .shadow(radius: 4)
        }
    }
    
    // MARK: - User Name
    private var userName: some View {
        let firstName = user.firstName ?? ""
        let lastName = user.lastName ?? ""
        return Text("\(firstName) \(lastName)")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.primary)
    }
    
    // MARK: - User Details
    private var userDetails: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(user.email ?? "")
                .font(.body)
            
            Text(user.phone ?? "")
                .font(.body)
            
            Text("\(UserConstants.ScreenLabels.age.rawValue)  \(user.age)")
                .font(.body)
        }
    }
    
    // MARK: - Address Section
    private var addressSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(UserConstants.ScreenLabels.address.rawValue)
                .font(.headline)
                .padding(.top)
            
            Text(user.address ?? "")
                .font(.body)
            
            Text(user.country ?? "")
                .font(.body)
        }
    }
}

