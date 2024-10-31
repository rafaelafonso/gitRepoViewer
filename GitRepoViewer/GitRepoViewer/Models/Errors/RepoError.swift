//
//  RepoError.swift
//  GitRepoViewer
//
//  Created by Rafael Afonso on 31/10/24.
//

import Foundation

class RepoError: Error {
    var message: String
    var userNotFound: Bool

    init(message: String, userNotFound: Bool) {
        self.message = message
        self.userNotFound = userNotFound
    }
}
