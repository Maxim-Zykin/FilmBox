//
//  MovieDetailViewModel.swift
//  FilmBox
//
//  Created by Максим Зыкин on 26.06.2024.
//

import Foundation
import UIKit

protocol MovieDetailViewModelProtocol {
    var imageData: Data? { get }
    var kinopoiskChart: String { get }
    var imdbChart: String { get }
    var movieNameRu: String { get }
    var movieNameEn: String { get }
    var description: String { get }
    var productionYearInfo: String { get }
    var durationInfo: String { get }
    init(movie: Movie)
}

class MovieDetailViewModel: MovieDetailViewModelProtocol {

    var imageData: Data? {
        let url = URL(string: movie.posterUrl!)
        return ImageManager.shared.fetchImage(from: url)
    }
    
    var kinopoiskChart: String {
        String(describing: movie.ratingKinopoisk ?? 0.0)
    }
    
    var imdbChart: String {
        String(describing: movie.ratingImdb ?? 0.0)
    }
    
    var movieNameRu: String {
        movie.nameRu ?? ""
    }
    
    var movieNameEn: String {
        movie.nameOriginal ?? ""
    }
    
    var description: String {
        movie.description ?? ""
    }
    
    var productionYearInfo: String {
        String(describing: movie.year)
    }
    
    var durationInfo: String {
        String(describing: movie.filmLength) + " мин."
    }
    
    private var movie: Movie
    
    required init(movie: Movie) {
        self.movie = movie
    }
    
    
}
