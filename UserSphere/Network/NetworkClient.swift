//
//  NetworkClient.swift
//  UserSphere

import Foundation
import Combine

// MARK: - Network Client Protocol
protocol NetworkClientProtocol {
    func request<T: Decodable>(apiRequest: APIRequest) -> AnyPublisher<T, Error>
}

// MARK: - Network Client
final class NetworkClient: NetworkClientProtocol {
    
    private let session: URLSession
    private let baseURL: String
    
    init(session: URLSession = .shared, baseURL: String = UserConstants.APIBaseURL.userAPI.rawValue) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func request<T: Decodable>(apiRequest: APIRequest) -> AnyPublisher<T, Error> {
        guard let url = URL(string: "\(baseURL)\(apiRequest.endpoint.rawValue)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiRequest.method.rawValue
        
        return session.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

