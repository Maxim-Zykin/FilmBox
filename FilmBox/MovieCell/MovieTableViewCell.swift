//
//  MovieTableViewCell.swift
//  FilmBox
//
//  Created by Максим Зыкин on 31.03.2024.
//

import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {
    
    static let cellID = "cellMovie"
    
    let poster = UIImageView()
    
    let nameMovie: UILabel! = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = ""
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    var viewModel: MovieTableViewModelCellProtocol! {
        didSet {
            if let urlString = viewModel.image {
                NetworkRequest.requestDataFetch(url: urlString) { [weak self] result in
                    switch result {
                    case .success(let data):
                        DispatchQueue.global().async {
                            let image = UIImage(data: data)
                            DispatchQueue.main.async {
                                self?.poster.image = image
                            }
                        }
                    case .failure(let error):
                        self?.poster.image = nil
                        print("No album image" + error.localizedDescription)
                    }
                }
            } else {
                poster.image = nil
            }
            nameMovie.text = viewModel.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(poster)
        contentView.addSubview(nameMovie)
        contentView.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 255/255)
        
        poster.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(100)
            make.width.equalTo(70)
        }
        
        nameMovie.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(poster.snp_centerYWithinMargins)
            make.left.equalTo(poster.snp_leftMargin).inset(80)
            make.right.equalTo(-5)
        }
    }
}
