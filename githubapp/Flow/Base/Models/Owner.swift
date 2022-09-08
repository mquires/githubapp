//
//  Owner.swift
//  githubapp
//
//  Created by wsa-151-41b on 7.09.22.
//

import Foundation

struct Owner: Codable {
    let id: Int?
    let avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatar_url"
    }
}
