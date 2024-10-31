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
            guard let data = data, let responseString = String(data: data, encoding: .utf8) else { return }

            if let error = error {
                print(">Error: \(error)")
                completion(.failure(error))
                return
            }

            guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                print(">Bad server response")
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            print(">Completion success!")
            completion(.success(data))
        }
        task.resume()
    }
}
