//
//  Network.swift
//  Geography
//
//  Created by Kevin Dieu on 10/11/22.
//

import Foundation

protocol NetworkType {
    func loadData(from urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case badUrl
    case badResponse
}

final class NetworkService: NetworkType {
    
    func loadData(from urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badUrl))
            return
        }
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(.badResponse))
                }
            }
        }.resume()
    }
}
