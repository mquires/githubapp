//
//  Repositories.swift
//  githubapp
//
//  Created by wsa-151-41b on 6.09.22.
//

import Foundation

struct Repository: Codable {
    let id: Int?
    let name: String?
    let owner: Owner?
    let repositoryDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, owner
        case repositoryDescription = "description"
    }
}
