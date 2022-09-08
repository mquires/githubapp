//
//  ApiManager.swift
//  githubapp
//
//  Created by wsa-151-41b on 6.09.22.
//

import Foundation

enum ApiType {
    case getRepositories
    case getRepositoryDetails(id: Int)
    
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

enum NetworkingError: String, Error {
    case invalidRequest = "You've made a bad request!"
    case BadRequest = "Bad Request"
    case Unauthorized = "Unauthorized"
    case Forbidden = "Forbidden"
    case notFound = "Not found"
    case InternalServerError = "Internal Server Error"
}

enum HTTPStatusCodes: Int {
    case OK = 200
    case BadRequest = 400
    case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
    case InternalServerError = 500
}

class ApiManager {
    static let shared = ApiManager()
    
    func getRepositories(completion: @escaping ((Result<[Repository], NetworkingError>) -> Void)) {
        let request = ApiType.getRepositories.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let status = response as? HTTPURLResponse {
                switch status.statusCode {
                case (HTTPStatusCodes.OK.rawValue):
                    if let data = data {
                        do {
                            let repositories = try JSONDecoder().decode([Repository].self, from: data)
                            
                            completion(.success(repositories))
                        } catch {
                            completion(.failure(.invalidRequest))
                        }
                    }
                case (HTTPStatusCodes.BadRequest.rawValue): return completion(.failure(.BadRequest))
                case (HTTPStatusCodes.Unauthorized.rawValue): return completion(.failure(.Unauthorized))
                case (HTTPStatusCodes.Forbidden.rawValue): return completion(.failure(.Forbidden))
                case (HTTPStatusCodes.NotFound.rawValue): return completion(.failure(.notFound))
                default: return completion(.failure(.InternalServerError))
                }
            }
        }
        
        task.resume()
    }
    
    func getRepositoryDetails(id: Int, completion: @escaping ((Result<RepositoryDetails, NetworkingError>) -> Void)) {
        let request = ApiType.getRepositoryDetails(id: id).request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let status = response as? HTTPURLResponse {
                switch status.statusCode {
                case (HTTPStatusCodes.OK.rawValue):
                    if let data = data {
                        do {
                            let repositoryDetails = try JSONDecoder().decode(RepositoryDetails.self, from: data)
                            
                            completion(.success(repositoryDetails))
                        } catch {
                            completion(.failure(.invalidRequest))
                        }
                    }
                case (HTTPStatusCodes.BadRequest.rawValue): return completion(.failure(.BadRequest))
                case (HTTPStatusCodes.Unauthorized.rawValue): return completion(.failure(.Unauthorized))
                case (HTTPStatusCodes.Forbidden.rawValue): return completion(.failure(.Forbidden))
                case (HTTPStatusCodes.NotFound.rawValue): return completion(.failure(.notFound))
                default: return completion(.failure(.InternalServerError))
                }
            }
        }
        
        task.resume()
    }
}

extension NetworkingError: LocalizedError {
    var descriptionError: String? {
        return NSLocalizedString(rawValue, comment: "")
    }
}
