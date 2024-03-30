//
//  MoviesSearch.swift
//  FilmBox
//
//  Created by Максим Зыкин on 30.03.2024.
//

import UIKit

struct MovieCellModel: Decodable, Equatable {
    let films: [MoviesSearch]
}

struct MoviesSearch: Decodable, Equatable {
    let filmId: Int?
    let nameRu: String?
    let nameEn: String?
    let posterUrl: String?
}
