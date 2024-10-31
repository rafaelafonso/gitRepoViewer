//
//  RepoViewModel.swift
//  GitRepoViewer
//
//  Created by Rafael Afonso on 31/10/24.
//

import SwiftUI

class RepoViewModel: ObservableObject {
    @Published var repos: [Repo]? = nil

    @Published var repoError: RepoError? = nil
    @Published var genericError: Bool = false
    @Published var userNotFound: Bool = false

    func fetchRepos(from username: String) {
        RepoService().fetchRepos(username: username) { result in
            switch result {
            case .success(let repos):
                self.repos = repos
            case .failure(let error):
                if error.userNotFound {
                    self.userNotFound = true
                } else {
                    self.genericError = true
                }
                self.repoError = error
            }
        }
    }
}
