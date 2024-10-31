//
//  NetworkManager.swift
//  GitRepoViewer
//
//  Created by Rafael Afonso on 31/10/24.
//

import Foundation

public enum GitRepoEndpoint: String {
    case fetchRepos = "/repos"
}

class NetworkManager {
    static let shared = NetworkManager()

    func getRequest(_ endpoint: GitRepoEndpoint, username: String, id: Int? = nil, completion: @escaping (Result<Data, Error>) -> Void) {

        var urlString: String = Config.baseURLString.rawValue.appending(username)
        urlString.append(endpoint.rawValue)

        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            guard let data = data, let _ = String(data: data, encoding: .utf8) else { return }

            let genericError: RepoError = RepoError(message: "A network error has occurred. Check your Internet connection and try again later.", userNotFound: false)
            let userNotFoundError: RepoError = RepoError(message: "User not found. Please enter another name", userNotFound: true)

            if let _ = error {
                completion(.failure(genericError))
                return
            }

            guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                print(">Bad server response. Status code \(httpResponse.statusCode)")
                if httpResponse.statusCode == 404 {
                    completion(.failure(userNotFoundError))
                } else {
                    completion(.failure(genericError))
                }
                return
            }
            print(">Completion success!")
            completion(.success(data))
        }
        task.resume()
    }
}
