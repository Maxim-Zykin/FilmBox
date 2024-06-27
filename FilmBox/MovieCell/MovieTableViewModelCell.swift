//
//  MovieTableViewModelCell.swift
//  FilmBox
//
//  Created by Максим Зыкин on 31.03.2024.
//

import UIKit

protocol MovieTableViewModelCellProtocol {
    var imageData: Data? { get }
    var name: String { get }
    var filmId: Int? { get }
    init(movie: MoviesSearch)
}

class MovieTableViewModelCell: MovieTableViewModelCellProtocol {
    
    var imageData: Data? {
        let url = URL(string: movie.posterUrl!)
        return ImageManager.shared.fetchImage(from: url)
        
    }
    
    var name: String {
        movie.nameRu ?? ""
    }
    
    var filmId: Int? {
        movie.filmId ?? 0
    }
    
    private var movie: MoviesSearch
    
    required init(movie: MoviesSearch) {
        self.movie = movie
    }
}
