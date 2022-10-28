//
//  NetworkCombine.swift
//  Geography
//
//  Created by Kevin Dieu on 10/27/22.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidURL, responseError, other(Error)
    
    static func map(_ error: Error) -> APIError {
      return (error as? APIError) ?? .other(error)
    }
}

protocol API {
    func execute<T: Codable>(decodeType: T.Type, urlString: String) -> AnyPublisher<T, APIError>
}

struct APINetworkTwo: API {
    func execute<T>(decodeType: T.Type, urlString: String) -> AnyPublisher<T, APIError> where T : Decodable, T : Encodable {
        let session = URLSession(configuration: .ephemeral)
        
        guard let url = URL(string: urlString) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .retry(1)
            .receive(on: DispatchQueue.main)
            .mapError{ _ in APIError.responseError }
            .eraseToAnyPublisher()
    }
}
