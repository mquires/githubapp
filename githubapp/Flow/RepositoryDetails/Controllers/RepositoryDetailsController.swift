//
//  RepositoryDetailsController.swift
//  githubapp
//
//  Created by wsa-151-41b on 7.09.22.
//

import UIKit

class RepositoryDetailsController: BaseController {
    var repositoryDetails: RepositoryDetails!
    
    private let avatarImage = UIImageView()
    private let ownerName = UILabel()
    private let urlLabel = UILabel()
    private let repositoryDescriptionLabel = UILabel()
    private let ownerLabel = UILabel()
    private let repositoryLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiManager.shared.getRepositoryDetails(id: "1") { result in
            switch result {
            case .success(let repositoryDetails):
                DispatchQueue.main.async {
                    self.repositoryDetails = repositoryDetails
                    self.setupPageData(repositoryDetails: repositoryDetails)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        configureSwipe()
    }
    
    override func addViews() {
        super.addViews()
        
        [avatarImage, urlLabel, repositoryDescriptionLabel, repositoryLabel, ownerLabel, ownerName].forEach {
            view.addSubview($0)
        }
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            ownerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            ownerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ownerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ownerLabel.heightAnchor.constraint(equalToConstant: 32),
            
            avatarImage.topAnchor.constraint(equalTo: ownerLabel.bottomAnchor, constant: 16),
            avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            avatarImage.widthAnchor.constraint(equalToConstant: 80),
            avatarImage.heightAnchor.constraint(equalToConstant: 80),
            
            ownerName.topAnchor.constraint(equalTo: avatarImage.topAnchor),
            ownerName.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 16),
            ownerName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            ownerName.heightAnchor.constraint(equalToConstant: 32),
            
            repositoryLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 15),
            repositoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            repositoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            repositoryLabel.heightAnchor.constraint(equalToConstant: 32),
            
            urlLabel.topAnchor.constraint(equalTo: repositoryLabel.bottomAnchor, constant: 16),
            urlLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            urlLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            urlLabel.heightAnchor.constraint(equalToConstant: 32),
            
            repositoryDescriptionLabel.topAnchor.constraint(equalTo: urlLabel.bottomAnchor, constant: 16),
            repositoryDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            repositoryDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            repositoryDescriptionLabel.heightAnchor.constraint(equalToConstant: 135),
        ])
    }
    
    override func configure() {
        super.configure()
        
        self.setTitleLabel(with: "Repository details")
        
        [avatarImage, urlLabel, repositoryDescriptionLabel, repositoryLabel, ownerLabel, ownerName].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        ownerLabel.text = "Owner"
        
        [ownerLabel, repositoryLabel, ownerName].forEach {
            $0.font = Resources.Fonts.subtitle
        }

        repositoryDescriptionLabel.numberOfLines = 0
    }
    
    func configureSwipe() {
        let swipeBack = UISwipeGestureRecognizer(target: self, action: #selector(swipeBack))
        swipeBack.direction = .right
        self.view.addGestureRecognizer(swipeBack)
    }
    
    @objc func swipeBack() {
        let rootViewController = GithubListController()
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        navigationViewController.modalPresentationStyle = .fullScreen

        present(navigationViewController, animated: true)
    }
    
    func setupPageData(repositoryDetails: RepositoryDetails) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            let data = try? Data(contentsOf: URL(string: (repositoryDetails.owner?.avatarURL)!)!)
            
            DispatchQueue.main.async {
                if let imageData = data {
                    self?.avatarImage.image = UIImage(data: imageData)
                } else {
                    self?.avatarImage.image = UIImage(named: "SomeEmptyImage")
                }
                
                self?.repositoryLabel.text = "Repository: \(repositoryDetails.fullName!)"
                self?.ownerName.text = repositoryDetails.name
                self?.urlLabel.text = repositoryDetails.url
                self?.repositoryDescriptionLabel.text = repositoryDetails.repositoryDescription
            }
        }
    }
}
