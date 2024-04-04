//
//  MovieDetailViewModel.swift
//  FilmBox
//
//  Created by Максим Зыкин on 01.04.2024.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    var imageMovie: String? { get }
    var filmId: Int? { get }
    var nameRu: String? { get }
    var nameOriginal: String? { get }
    var ratingKinopoisk: Double? { get }
    var ratingImdb: Double? { get }
//    var year: Int { get }
//    var filmLength: String? { get }
    var description: String? { get }
    init(movie: MoviesSearch)
}

class MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    var imageMovie: String? {
        movie.posterUrl ?? ""
    }
    
    var filmId: Int? {
        movie.filmId ?? 0
    }
    
    var nameRu: String? {
        movie.nameRu ?? ""
    }
    
    var nameOriginal: String? {
        movie.nameOriginal ?? ""
    }
    
    var ratingKinopoisk: Double? {
        movie.ratingKinopoisk ?? 0.0
    }
    
    var ratingImdb: Double? {
        movie.ratingImdb ?? 0.0
    }
    
//    var year: Int {
//        movie.year
//    }
//    
//    var filmLength: String? {
//        String(movie.filmLength ?? 0)
//       
//    }
    
    var description: String? {
        movie.description ?? ""
    }
    
    private var movie: MoviesSearch
    
    required init(movie: MoviesSearch) {
        self.movie = movie
    }
}
