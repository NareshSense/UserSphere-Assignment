//
//  UserDataMapper.swift
//  UserSphere

// MARK: - Mapper Protocol
protocol MapperProtocol {
    func dtoToDomain(userData: UserData) -> User
}

// MARK: - Mapper Implementation
final class UserDataMapper: MapperProtocol {
    func dtoToDomain(userData: UserData) -> User {
        return User(
            id: userData.id,
            firstName: userData.firstName ?? "",
            lastName: userData.lastName ?? "",
            email: userData.email ?? "",
            phone: userData.phone ?? "",
            age: userData.age,
            image: userData.image,
            address: userData.address?.address ?? "",
            country: userData.address?.country
        )
    }
}
