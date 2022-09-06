//
//  GithubListController.swift
//  githubapp
//
//  Created by wsa-151-41b on 6.09.22.
//

import UIKit

class GithubListController: BaseController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        super.configure()
        
        self.setTitleLabel(with: "Github list")
        
        ApiManager.shared.getRepositories { repositories in
            print(repositories)
        }
    }
}
