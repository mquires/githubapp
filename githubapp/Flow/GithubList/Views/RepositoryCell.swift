//
//  RepositoryCell.swift
//  githubapp
//
//  Created by wsa-151-41b on 6.09.22.
//

import UIKit

class RepositoryCell: UITableViewCell {
    private let avatar = UIImageView()
    private let nameLabel = UILabel()
    private let repositoryDescriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        layoutViews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        [avatar, nameLabel, repositoryDescriptionLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            avatar.widthAnchor.constraint(equalToConstant: 32),
            avatar.heightAnchor.constraint(equalToConstant: 32),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            nameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            repositoryDescriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            repositoryDescriptionLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 8),
            repositoryDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            repositoryDescriptionLabel.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
    
    func configure() {
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        repositoryDescriptionLabel.font = UIFont.systemFont(ofSize: 10)
        
        [avatar, nameLabel, repositoryDescriptionLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupCellData(repository: Repository) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            let data = try? Data(contentsOf: URL(string: (repository.owner?.avatarURL)!)!)
            
            DispatchQueue.main.async {
                if let imageData = data {
                    self?.avatar.image = UIImage(data: imageData)
                } else {
                    self?.avatar.image = UIImage(named: "SomeEmptyImage")
                }
                
                self?.nameLabel.text = repository.name
                self?.repositoryDescriptionLabel.text = repository.repositoryDescription
            }
        }
    }
}
