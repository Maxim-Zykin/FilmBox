//
//  HomePageViewController.swift
//  FilmBox
//
//  Created by Максим Зыкин on 30.03.2024.
//

import UIKit
import SnapKit

class HomePageViewController: UIViewController, UITextFieldDelegate {
    
    private var isSearch = true
    
    private let lableApp: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 46, weight: .bold)
        label.textColor = UIColor(red: 255/255, green: 199/255, blue: 0/255, alpha: 255/255)
        label.text = "FilmBox"
    return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        indicator.startAnimating()
        return indicator
    }()
    
    private let serchTextField = CustomTextField(filedTypr: .search)
    
    private let buttonSerch = CustomButtons(title: "Поиск", fontSize: .med)
    
    private var table: UITableView = {
        let tableView = UITableView()
        tableView.sectionHeaderTopPadding = 0
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.cellID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 255/255)
        return tableView
    }()
    
    private var viewModel: HomePageViewModelProtocol! {
        didSet {
            self.isSearch = false
            viewModel.fetchMovies {
                DispatchQueue.main.async {
                self.table.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomePageViewModel()
        setupUI()
        addTarget()
        table.dataSource = self
        table.delegate = self
        serchTextField.delegate = self
    }
    
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        userText.resignFirstResponder()
        return true;
    }
    
    func addTarget() {
        buttonSerch.addTarget(self, action: #selector(tabSerch), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true);
        }
    
    @objc func tabSerch() {
        self.view.endEditing(true)
        guard serchTextField.text != "" else {
            self.isSearch = false
            viewModel.fetchMovies {
                DispatchQueue.main.async {
                self.table.reloadData()
                }
            }
            return }
        
        guard let movieName = serchTextField.text else { return }
        self.isSearch = true
        viewModel.fetchMoviesSerch(nameFilm: movieName) {
            DispatchQueue.main.async {
               self.table.reloadData()
            }
        }
    }

    func setupUI() {
        view.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 255/255)
        self.view.addSubview(lableApp)
        self.view.addSubview(serchTextField)
        self.view.addSubview(buttonSerch)
        self.view.addSubview(table)
        self.view.addSubview(activityIndicator)
        
        lableApp.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.equalTo(20)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(table.snp.center)
        }
        
        serchTextField.snp.makeConstraints { make in
            make.top.equalTo(lableApp.snp_bottomMargin).inset(-30)
            make.left.equalTo(20)
            make.right.equalTo(-120)
            make.height.equalTo(40)
        }
        
        buttonSerch.snp.makeConstraints { make in
            make.top.equalTo(lableApp.snp_bottomMargin).inset(-30)
            make.left.equalTo(serchTextField.snp_rightMargin).inset(-20)
            make.width.equalTo(90)
            make.height.equalTo(40)
        }
        
        table.snp.makeConstraints { make in
            make.top.equalTo(buttonSerch.snp_bottomMargin).inset(-30)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}


extension HomePageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellID, for: indexPath) as! MovieTableViewCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
}

extension HomePageViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailMovieVC = MovieDetailViewController()
        let movie = viewModel.viewModelForSelectedRow(at: indexPath)

        detailMovieVC.movieId = movie
        present(detailMovieVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = .darkGray
            header.tintColor = UIColor(red: 255/255, green: 199/255, blue: 0/255, alpha: 255/255)
            header.textLabel?.font = UIFont(name: "Helvetica-Regular", size: 15)
            header.textLabel?.numberOfLines = 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearch {
            return "Результаты по запросу: \(serchTextField.text ?? "")"
        } else {
            return "Популярные фильмы "
        }
    }
}
