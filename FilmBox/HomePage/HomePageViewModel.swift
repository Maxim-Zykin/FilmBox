//
//  HomePageViewModel.swift
//  FilmBox
//
//  Created by Максим Зыкин on 30.03.2024.
//

import UIKit

protocol HomePageViewModelProtocol {
    var movies: [MoviesSearch] { get }
    func fetchMovies(completion: @escaping() -> Void)
    func fetchMoviesSerch(nameFilm: String, completion: @escaping () -> Void)
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> MovieTableViewModelCellProtocol
    func viewModelForSelectedRow(at indexPath: IndexPath) -> Int
    
}

class HomePageViewModel: HomePageViewModelProtocol {
    
    var movies: [MoviesSearch] = []
    
    func fetchMovies(completion: @escaping () -> Void) {
       let url = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS"
        NetworkDataFetch.fetchMovies(urlString: url) { [weak self] popularMovieCellModel,
            error in
            if error == nil {
                guard let popularMovieCellModel = popularMovieCellModel else { return }
                self?.movies = popularMovieCellModel.films
                print("успеХ, \(self!.movies.count)")
                completion()
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func fetchMoviesSerch(nameFilm: String, completion: @escaping () -> Void) {
       let url = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(nameFilm)"
        NetworkDataFetch.fetchMovies(urlString: url) { [weak self] popularMovieCellModel,
            error in
            if error == nil {
                guard let popularMovieCellModel = popularMovieCellModel else { return }
                self?.movies = popularMovieCellModel.films
                print("успех, \(self!.movies.count)")
                completion()
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func numberOfRows() -> Int {
       return movies.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> MovieTableViewModelCellProtocol {
        let movies = movies[indexPath.row]
        return MovieTableViewModelCell(movie: movies)
    }
    
    func viewModelForSelectedRow(at indexPath: IndexPath) -> Int {
        let detail = movies[indexPath.row].filmId ?? 0
        return detail
    }
    
    func viewModelForSelectedRow(at indexPath: IndexPath) -> MovieDetailViewModel {
        let detail = movies[indexPath.row].filmId ?? 0
        let movie = MovieDetailViewModel(movieID: detail)
        return movie
    }

}
