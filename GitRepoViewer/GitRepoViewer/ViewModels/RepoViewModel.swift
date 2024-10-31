//
//  RepoViewModel.swift
//  GitRepoViewer
//
//  Created by Rafael Afonso on 31/10/24.
//

import SwiftUI

class RepoViewModel: ObservableObject {
    @Published var repos: [Repo]? = nil

    func fetchRepos(from username: String) {
        RepoService().fetchRepos(username: username) { result in
            switch result {
            case .success(let repos):
                print(">VM success")
                self.repos = repos
            case .failure(_):
                print("> error") //TODO: error to be handled
            }
        }
    }
}
