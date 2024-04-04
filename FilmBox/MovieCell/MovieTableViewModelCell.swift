//
//  MovieTableViewModelCell.swift
//  FilmBox
//
//  Created by Максим Зыкин on 31.03.2024.
//

import UIKit

protocol MovieTableViewModelCellProtocol {
    var image: String? { get }
    var name: String { get }
    var filmId: Int? { get }
    init(movie: MoviesSearch)
}

class MovieTableViewModelCell: MovieTableViewModelCellProtocol {
    
    var image: String? {
        movie.posterUrl ?? ""
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
