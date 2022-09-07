//
//  RepositoryDetailsController.swift
//  githubapp
//
//  Created by wsa-151-41b on 7.09.22.
//

import UIKit

class RepositoryDetailsController: BaseController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeBack = UISwipeGestureRecognizer(target: self, action: #selector(swipeBack))
        swipeBack.direction = .right
        self.view.addGestureRecognizer(swipeBack)
    }
    
    override func configure() {
        super.configure()
        
        self.setTitleLabel(with: "Repository details")
    }
    
    @objc func swipeBack() {
        let rootViewController = GithubListController()
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        navigationViewController.modalPresentationStyle = .fullScreen

        present(navigationViewController, animated: true)
    }
}
