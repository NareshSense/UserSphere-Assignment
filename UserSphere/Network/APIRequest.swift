//
//  APIRequest.swift
//  UserSphere

// MARK: - HTTP Method Enum
enum HTTPMethod: String {
    case GET
    case POST
}

// MARK: - APIRequest
final class APIRequest {
    let baseURL: String
    var method: HTTPMethod
    var endpoint: APIEndpoints
    
    init(baseURL: String, method: HTTPMethod, endpoint: APIEndpoints) {
        self.baseURL = baseURL
        self.method = method
        self.endpoint = endpoint
    }
}



