//
//  NetworkDataFetch.swift
//  FilmBox
//
//  Created by Максим Зыкин on 30.03.2024.
//

import Foundation

class NetworkDataFetch<T: Decodable> {
    
    static func fetchMovies(url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
        NetworkRequest.requestDataFetch(url: url) { result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    completion(json as! Result<T, NetworkError>)
                }  catch let error {
                    print("Failed to decode JSON", error)
                }
            case .failure(let error):
                completion(.failure(.error(err: "\(error)")))
            }
        }
    }
}


enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case decodingError(err: String)
    case error(err: String)
}
