//
//  ApiManager.swift
//  githubapp
//
//  Created by wsa-151-41b on 6.09.22.
//

import Foundation

enum ApiType {
    case getRepositories
    
    var baseURL: String {
        return "https://api.github.com/"
    }
    
    var path: String {
        switch self {
        case .getRepositories:
            return "repositories"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURL)!)!
        var request = URLRequest(url: url)
        
        switch self {
        case .getRepositories:
            request.httpMethod = "GET"
            
            return request
        }
    }
}

class ApiManager {
    static let shared = ApiManager()
    
    func getRepositories(completion: @escaping (([Repository]) -> Void)) {
        let request = ApiType.getRepositories.request
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data, let repositories = try? JSONDecoder().decode([Repository].self, from: data) {
                completion(repositories)
            } else {
                completion([])
            }
        }
        
        task.resume()
    }
}