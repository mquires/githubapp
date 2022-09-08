//
//  GithubListController.swift
//  githubapp
//
//  Created by wsa-151-41b on 6.09.22.
//

import UIKit

class GithubListController: BaseController {
    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
    
    var repositoriesList: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        ApiManager.shared.getRepositories { result in
            switch result {
            case .success(let repositories):
                DispatchQueue.main.async {
                    self.repositoriesList = repositories
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: "RepositoryCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func configure() {
        super.configure()
        
        self.setTitleLabel(with: "Github list")
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        tableView.backgroundColor = Resources.Colors.background
    }
}

extension GithubListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositoriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepositoryCell else {
            return UITableViewCell()
        }
        
        cell.setupCellData(repository: repositoriesList[indexPath.row])
        
        return cell
    }
}

extension GithubListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootViewController = RepositoryDetailsController()
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        navigationViewController.modalPresentationStyle = .fullScreen

        present(navigationViewController, animated: true)
    }
}
