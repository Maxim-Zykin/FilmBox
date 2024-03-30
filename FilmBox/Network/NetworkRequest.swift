//
//  NetworkRequest.swift
//  FilmBox
//
//  Created by Максим Зыкин on 30.03.2024.
//

import UIKit

class NetworkRequest{
    
    static func requestDataFetch(url: String, completion: @escaping (Result<Data, Error>) ->()) {
        guard let urlEncoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        guard let url = URL(string: urlEncoded) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request) {data, _, error  in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
}
