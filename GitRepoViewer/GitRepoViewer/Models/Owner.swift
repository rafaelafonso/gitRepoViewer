//
//  Owner.swift
//  GitRepoViewer
//
//  Created by Rafael Afonso on 31/10/24.
//

import Foundation

struct Owner: Codable, Hashable, Identifiable, Equatable {

    private enum CodingKeys: String, CodingKey {
        case id, username = "login", avatarURL = "avatar_url"
    }

    let id: Int
    let username: String
    let avatarURL: String?

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.username = try container.decode(String.self, forKey: .username)
        self.avatarURL = try container.decodeIfPresent(String.self, forKey: .avatarURL)
    }
}
