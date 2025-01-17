

# User Sphere app
This is a SwiftUI-based project that demonstrates a User App featuring a User List Screen and User Detail Screen. The project follows Clean Architecture principles and provides a scalable, maintainable, and testable codebase.

# Table of contents 
1. Overview
2. Features
3. Architecture
4. Installation
5. Usage
6. Key Folder and Files
7. Testing

# Overview
The User Sphere App is designed to demonstrate modern iOS development practices, focusing on Clean Architecture to separate concerns and ensure maintainability.

The app consists of two main screens:

User List Screen: Displays a list of users, fetched from a remote API, and shows basic information like names and email addresses.
User Detail Screen: Displays detailed information about a user, including their address, phone number, and image.
The data is fetched from a remote API (a mock API in this case) and follows best practices like caching images and handling  errors.

# Features
User List Screen: Displays a list of users with their first name, last name, and email address.
User Detail Screen: Shows more detailed information about a user, including phone number, address, country, and an optional profile picture.
Image Caching: Cached images for user profiles to improve performance and avoid unnecessary network requests.
Error Handling: Graceful error handling, with appropriate feedback to users when there are issues fetching data.
State Management: Clear separation of concerns using ViewModels to manage UI state.
Unit Testing: Comprehensive tests to ensure reliability and maintainability.
Architecture

The project follows the Clean Architecture pattern, with the following layers:

Presentation Layer:
Views: UserListView and UserDetailView are SwiftUI views that display the user interface.
ViewModels: UsersViewModel and UserDetailViewModel manage the data and business logic required by the views.

Domain Layer:
Entities: User is the core data model representing a user.
UseCases: Handles the business logic for interacting with the user repository.

Repositories: UserRepository is responsible for fetching user data, either from the network or from a local cache.

Data Layer:
API Layer: Makes network requests using UserDataServiceProtocol and handles the API response.
Cache: A custom ImageCache class is used to cache user images for efficient network usage and improved app performance.
The code uses Combine for reactive programming and asynchronous data flow.

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

# Key folder and files
Views: Contains all SwiftUI views that make up the user interface.
ViewModels: Contains the business logic for each screen (e.g., fetching users, managing states).
Models: Contains the core data models like User.
Services: Contains the API service and image cache for network calls and local caching.
Repositories: Handles data fetching from various sources (e.g., API, cache).
Tests: Contains unit tests for repositories, view models, and UI components.

# Testing
The project includes unit tests for both ViewModels and Repositories, ensuring reliability and robustness. The tests include coverage for:

Fetching data from the API.
Transitions and UI updates in UserListView and UserDetailView.

To run the tests:

Open the project in Xcode.
Select Product > Test from the Xcode menu or press Cmd + U.
Xcode will run the tests, and you can view the results in the Test Navigator.





