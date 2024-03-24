//
//  ViewController.swift
//  FilmBox
//
//  Created by Максим Зыкин on 24.03.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let serchTextField = CustomTextField(filedTypr: .search)
    
    let buttonURLSession = CustomButtons(title: "URLSession", fontSize: .med)
    
    let buttonAlamofire = CustomButtons(title: "Alamofire", fontSize: .med)
    
    var resultTextField = CustomTextField(filedTypr: .result)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addTarget()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 255/255)
        self.view.addSubview(serchTextField)
        self.view.addSubview(buttonURLSession)
        self.view.addSubview(buttonAlamofire)
        self.view.addSubview(resultTextField)
        
        serchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }
        
        buttonURLSession.snp.makeConstraints { make in
            make.top.equalTo(serchTextField.snp_bottomMargin).inset(-40)
            make.left.equalTo(20)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
        buttonAlamofire.snp.makeConstraints { make in
            make.top.equalTo(serchTextField.snp_bottomMargin).inset(-40)
            make.right.equalTo(-20)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
        resultTextField.snp.makeConstraints { make in
            make.top.equalTo(buttonAlamofire.snp_bottomMargin).inset(-40)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(350)
        }
    }
    
    func addTarget() {
        self.buttonURLSession.addTarget(self, action: #selector(tapURLSesion), for: .touchUpInside)
        
    }

    @objc func tapURLSesion() {
        guard let serchFilm = serchTextField.text else { return }
        
        let url = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(serchFilm)"
        let apiKey = "6fda98fe-18df-45e9-b5f8-8888ca001b5d"
        let urlString = URL(string: url)
        
        var request = URLRequest(url: urlString!)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        
        let tast = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                self.resultTextField.text = error.localizedDescription
            } else {
                if let data = data, let json = try?JSONSerialization.jsonObject(with: data, options: []) {
                    DispatchQueue.main.async {
                        self.resultTextField.text = json as? String
                        print(json)
                    }
                }
            }
        }
        tast.resume()
    }
    
}

