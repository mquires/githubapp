//
//  BaseController.swift
//  githubapp
//
//  Created by wsa-151-41b on 6.09.22.
//

import UIKit

class BaseController: UIViewController {
    private let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        layoutViews()
        configure()
    }
    
    func setTitleLabel(with title: String) {
        titleLabel.text = title
    }
    
    func addViews() {
        view.addSubview(titleLabel)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    func configure() {
        view.backgroundColor = Resources.Colors.background
    
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = Resources.Colors.black
        titleLabel.font = Resources.Fonts.bold
    }
}
