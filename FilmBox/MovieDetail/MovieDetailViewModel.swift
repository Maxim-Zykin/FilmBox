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
    var movieNameEn: String { get set }
    var description: String { get }
    var productionYearInfo: String { get }
    var durationInfo: String { get }
    //var movie: Movie { get }
    func fetchMovie(completion: @escaping() -> Void)
    //init(movieId: MoviesSearch)
    init(movieID: Int)
}

class MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    var movieId: Int
    
    required init(movieID: Int) {
        self.movieId = movieID
    }
    
    var imageURL: String = ""
    
//    var movie: Movie
    
    var imageData: Data? {
        let url = URL(string: imageURL)
        return ImageManager.shared.fetchImage(from: url)
    }
    
    var kinopoiskChart: String = ""
    
    var imdbChart: String = ""
    
    var movieNameRu: String = ""
    
    var movieNameEn: String = ""
    
    var description: String = ""
    
    var productionYearInfo: String = ""
    
    var durationInfo: String = ""
    
    
    func fetchMovie(completion: @escaping () -> Void) {

        let url = "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(movieId)"
        
        NetworkDataFetch.fetchMovieDetail(urlString: url) { [weak self] movieModel, error in
            if error == nil {
                guard let movieModel = movieModel else { return }
                self?.kinopoiskChart = String(movieModel.ratingKinopoisk ?? 0)
                self?.imdbChart = String(movieModel.ratingImdb ?? 0)
                self?.movieNameRu = movieModel.nameOriginal ?? ""
                self?.movieNameEn = movieModel.nameOriginal ?? ""
                self?.description = movieModel.description ?? ""
                self?.productionYearInfo = String(movieModel.year ?? 0)
                self?.durationInfo = String(movieModel.filmLength ?? 0)
                
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
}
