//
//  ViewController.swift
//  FilmBox
//
//  Created by Максим Зыкин on 24.03.2024.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {

    let serchTextField = CustomTextField(filedTypr: .search)
    
    let buttonURLSession = CustomButtons(title: "URLSession", fontSize: .med)
    
    let buttonAlamofire = CustomButtons(title: "Alamofire", fontSize: .med)
    
    var resultTextView = UITextView()
    
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
        self.view.addSubview(resultTextView)
        
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
        
        resultTextView.snp.makeConstraints { make in
            make.top.equalTo(buttonAlamofire.snp_bottomMargin).inset(-40)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(550)
        }
    }
    
    func addTarget() {
        self.buttonURLSession.addTarget(self, action: #selector(tapURLSesion), for: .touchUpInside)
        self.buttonAlamofire.addTarget(self, action: #selector(tapAlamofire), for: .touchUpInside)
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
                self.resultTextView.text = error.localizedDescription
            } else {
                if let data = data, let json = try?JSONSerialization.jsonObject(with: data, options: []) {
                    
                    let convertedString = String(data: data, encoding: .utf8)
                    
                    DispatchQueue.main.async {
                        self.resultTextView.text = convertedString
                    }
                }
            }
        }
        tast.resume()
    }
    
    @objc func tapAlamofire() {
        guard let serchFilm = serchTextField.text else { return }
        
        let url = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(serchFilm)"
        let apiKey = "6fda98fe-18df-45e9-b5f8-8888ca001b5d"
        let urlString = URL(string: url)
        
        let headers: HTTPHeaders = ["X-API-KEY": apiKey]
        AF.request(urlString!, headers: headers).responseString(completionHandler: { result in
            let resp = String (bytes: result.data!, encoding: . utf8)
            
            let res = result
            DispatchQueue.main.async {
                self.resultTextView.text = resp
                print(res)
            }
        })
//
//        let dataTask = AF.request(urlString!, method: .get, headers: headers)
//        let decoded = dataTask.serializingDecodable(String.self)
//        let response = await decoded.response
//        let result = response.result
//        
//        print(result)

    }
    
}

