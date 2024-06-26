//
//  ImageManager.swift
//  FilmBox
//
//  Created by Максим Зыкин on 31.03.2024.
//

import Foundation

class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: URL?) -> Data? {
        guard let url = url else { return nil}
        guard let imageData = try? Data(contentsOf: url) else { return nil}
        return imageData
    }
}
