
# User Sphere app
This is a SwiftUI-based project that demonstrates a User App featuring a User List Screen and User Detail Screen. The project follows Clean Architecture principles and provides a scalable, maintainable, and testable codebase.

# Table of contents 
1. Overview
2. Features
3. Architecture
4. Installation
5. Usage
6. Dependencies
7. Testing

# Overview
The User Sphere App is designed to demonstrate modern iOS development practices, focusing on Clean Architecture to separate concerns and ensure maintainability.

The app consists of two main screens:

Users Listing Screen: Displays a list of users, fetched from a remote API, and shows basic information like names and email addresses.

User Details Screen: Displays detailed information about a user, including their name, email, address, phone number, country and image.

The data is fetched from a remote API (a sample API in this case) and follows best practices like caching images and handling  errors.

# Features
User List Screen: Displays a list of users with their first name, last name, and email address.

User Detail Screen: Shows more detailed information about a user, including name, email, phone number, address, country, and profile picture.

<p align="center">
  <img src="https://github.com/user-attachments/assets/6e03e681-b556-432d-9915-1d9c9b357b5b" width="45%" style="border: 2px solid #ddd; border-radius: 8px; padding: 5px; margin-right: 15px;">
  <img src="https://github.com/user-attachments/assets/44679103-57be-4581-8eca-acb644afbade" width="45%" style="border: 2px solid #ddd; border-radius: 8px; padding: 5px;">
</p>

# Architecture
The project follows the Clean Architecture pattern, with the following layers:

Presentation Layer:
Views: UserListView and UserDetailView are SwiftUI views that display the user interface.
ViewModels: UsersViewModel and UserDetailViewModel manage the data and business logic required by the views.

Domain Layer:
Entities: User is the core data model representing a user entity. Once created should not be changed ideally.
UseCases: Handles the business logic for interacting with the user repository.
Repository protocol: UserRepository is responsible for fetching user data from data service and provide to use case.

Data Layer:
DataService: Implements UserDataServiceProtocol, interacts with the network client and gets user data.
Repository: Contains implementation of UserRepository protocol, Mappers used here to convert data models to entity.
Data Models: API response from network client is mapped to data model.

Network client class is responsible for API interactions.

The code uses Combine for reactive programming, asynchronous data flow and Swift UI for User Interface.

# Installation
To get started with the project, follow these steps:

1. Clone the repository
2. Open the project in Xcode
Open the .xcodeproj file in Xcode.
4. Build and run the app
Select a simulator or your physical device in Xcode, and press Cmd + R to build and run the app.

# Usage
Upon launching the app, you will see two main screens:

1. User List Screen:
This screen shows a list of users. Each user is displayed with their first name, last name, and email.
Tapping on a user will navigate to the User Detail Screen.
2. User Detail Screen:
This screen shows detailed information about the user, such as their phone number, address, country, and profile picture (if available).
You can interact with the app like a typical user, and the data will be loaded asynchronously from the API.

# Dependencies 
SPM Dependencies such as ViewInspector and SnapshotTesting have been used in testing target to support inspectable views and snapshots

# Testing
The project includes tests for Data Service, Repositories, Use Cases, ViewModels and Views ensuring reliability, coverage and robustness.

Code coverage:

Code coverage achieved for UserSphere app is 93.8%

<img width="772" alt="Coverage" src="https://github.com/user-attachments/assets/8bc3bec5-342b-4988-85e4-bc47e9993771" />

To run the tests:
Open the project in Xcode.
Select Product > Test from the Xcode menu or press Cmd + U.
Xcode will run the tests, and you can view the results in the Test Navigator.
