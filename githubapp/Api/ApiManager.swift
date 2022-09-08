//
//  ApiManager.swift
//  githubapp
//
//  Created by wsa-151-41b on 6.09.22.
//

import Foundation

enum ApiType {
    case getRepositories
    case getRepositoryDetails(id: String)
    
    var baseURL: String {
        return "https://api.github.com/"
    }
    
    var path: String {
        switch self {
        case .getRepositories:
            return "repositories"
        case .getRepositoryDetails(let id):
            return "repositories/\(id)"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURL)!)!
        var request = URLRequest(url: url)
        
        switch self {
        case .getRepositories:
            request.httpMethod = "GET"
            
            return request
        case .getRepositoryDetails:
            request.httpMethod = "GET"
            
            return request
        }
    }
}

class ApiManager {
    static let shared = ApiManager()
    
    func getRepositories(completion: @escaping ((Result<[Repository], Error>) -> Void)) {
        let request = ApiType.getRepositories.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let status = response as? HTTPURLResponse {
                print("status code: \(status.statusCode)")
            }
            
            if let data = data {
                do {
                    let repositories = try JSONDecoder().decode([Repository].self, from: data)
                    
                    completion(.success(repositories))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }

    func getRepositoryDetails(id: String, completion: @escaping ((Result<RepositoryDetails, Error>) -> Void)) {
        let request = ApiType.getRepositoryDetails(id: id).request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let status = response as? HTTPURLResponse {
                print("status code: \(status.statusCode)")
            }

            if let data = data {
                do {
                    let repositoryDetails = try JSONDecoder().decode(RepositoryDetails.self, from: data)

                    completion(.success(repositoryDetails))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
}
