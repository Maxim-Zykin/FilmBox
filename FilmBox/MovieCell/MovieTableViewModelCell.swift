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
    init(movie: MoviesSearch)
}

class MovieTableViewModelCell: MovieTableViewModelCellProtocol {
    
    var image: String? {
        movie.posterUrl
    }
    
    var name: String {
        movie.nameRu ?? ""
    }
    
    private var movie: MoviesSearch
    
    required init(movie: MoviesSearch) {
        self.movie = movie
    }
}
