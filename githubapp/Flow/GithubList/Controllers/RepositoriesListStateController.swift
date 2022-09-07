////
////  RepositoriesListStateController.swift
////  githubapp
////
////  Created by wsa-151-41b on 7.09.22.
////
//
//import UIKit
//
//class RepositoriesListStateController {
//    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
//    
//    var repositoriesList: [Repository] = []
//
//    init(view: view) {
//        setupTableView(view: view)
//        
//        
//        ApiManager.shared.getRepositories { result in
//            switch result {
//            case .success(let repositories):
//                DispatchQueue.main.async {
//                    self.repositoriesList = repositories as [Repository]
//                    self.tableView.reloadData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//        
//    }
//    
//    func setupTableView(view: view) {
//        view.addSubview(tableView)
//        
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        ])
//        
//        tableView.backgroundColor = Resources.Colors.background
//    }
//    
//    func numberOfRepositories() -> Int {
//            return repositoriesList.count
//        }
//    
//    func getRepositoriesList() -> [Repository] {
//        return self.repositoriesList
//    }
//}
//
//class RepositoriesListTableViewDataSource: NSObject {
//    let repositoriesListStateController: RepositoriesListStateController
//    let tableView: UITableView
//
//    init(stateController: RepositoriesListStateController, tableView: UITableView) {
//        repositoriesListStateController = stateController
//        self.tableView = tableView
//        self.tableView.register(RepositoryCell.self, forCellReuseIdentifier: "RepositoryCell")
//        super.init()
//        self.tableView.dataSource = self
//    }
//}
//
//extension RepositoriesListTableViewDataSource: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return repositoriesListStateController.numberOfRepositories()
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepositoryCell else {
//            fatalError()
//        }
//        
//        cell.setupCellData(repository: repositoriesListStateController.getRepositoriesList()[indexPath.row])
//        
//        return cell
//    }
//}
