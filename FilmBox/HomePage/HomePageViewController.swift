//
//  HomePageViewController.swift
//  FilmBox
//
//  Created by Максим Зыкин on 30.03.2024.
//

import UIKit

class HomePageViewController: UIViewController {
    
    private let lableApp: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 46, weight: .bold)
        label.textColor = UIColor(red: 255/255, green: 199/255, blue: 0/255, alpha: 255/255)
        label.text = "FilmBox"
    return label
    }()
    
    private let serchTextField = CustomTextField(filedTypr: .search)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    func setupUI() {
        view.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 255/255)
        self.view.addSubview(lableApp)
        self.view.addSubview(serchTextField)
        
        lableApp.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.equalTo(20)
        }
        
        serchTextField.snp.makeConstraints { make in
            make.top.equalTo(lableApp.snp_bottomMargin).inset(-30)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }
    }
}
