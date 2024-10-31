//
//  RepoService.swift
//  GitRepoViewer
//
//  Created by Rafael Afonso on 31/10/24.
//

import Foundation

struct RepoService {

    func fetchRepos(username: String, completion: @escaping (Result<[Repo], RepoError>) -> Void) {

        NetworkManager.shared.getRequest(.fetchRepos, username: username) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        let repos = try JSONDecoder().decode([Repo].self, from: data)
                        print(">Service success")
                        completion(.success(repos))
                    } catch {
                        print(">Service error #1: \(error.localizedDescription)")
                        completion(.failure(RepoError(message: error.localizedDescription)))
                    }
                case .failure(let error):
                    print(">Service error #2: \(error.localizedDescription)")
                    completion(.failure(RepoError(message: error.localizedDescription)))
                }
            }
        }
    }
}
