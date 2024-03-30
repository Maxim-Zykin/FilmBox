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
//    func cellViewModel(at indexPath: IndexPath) -> CharactersCollectionViewModelCellProtocol
//    func viewModelForSelectedRow(at indexPath: IndexPath) -> DetailViewModelProtocol
}

class HomePageViewModel: HomePageViewModelProtocol {
    
    var movies: [MoviesSearch] = []
    
    func fetchMovies(completion: @escaping () -> Void) {
        print()
    }
    
    
}
