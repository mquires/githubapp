//
//  RepositoryDetails.swift
//  githubapp
//
//  Created by wsa-151-41b on 7.09.22.
//

import Foundation

struct RepositoryDetails: Codable {
    let id: Int?
    let name: String?
    let fullName, url, repositoryDescription: String?
    let owner: Owner?
    
    enum CodingKeys: String, CodingKey {
        case id, url, owner
        case name
        case fullName = "full_name"
        case repositoryDescription = "description"
    }
}
