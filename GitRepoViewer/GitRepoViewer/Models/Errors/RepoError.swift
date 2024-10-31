//
//  RepoError.swift
//  GitRepoViewer
//
//  Created by Rafael Afonso on 31/10/24.
//

import Foundation

class RepoError: Error {
    var message: String

    init(message: String) {
        self.message = message
    }
}
