//
//  UserConstants.swift
//  UserSphere
//
//  Created by Naresh Motwani
//

import Foundation

enum UserConstants {
    enum ErrorMessages: String {
        case loading = "Loading..."
        case noUsersAvailable = "No users available."
        case errorPrefix = "Error: "
    }
    
    enum ButtonTitles: String {
        case retry = "Retry"
    }
    
    enum AlertMessages: String {
        case generalErrorTitle = "Error"
        case generalErrorMessage = "Something went wrong."
        case ok = "OK"
    }
    
    enum ScreenLabels: String {
        case address = "Address"
        case age = "Age:"
    }
    
    enum NavigationTitles: String {
        case userDetail = "User Details"
        case userListing = "Users"
    }
    
    enum ImageIcons: String {
        case rightChevron = "chevron.right"
        case defaultPersonImage = "person.circle.fill"
        case leftChevron = "chevron.left"
    }
    
    enum APIBaseURL: String {
        case userAPI = "https://dummyjson.com"
    }
}

