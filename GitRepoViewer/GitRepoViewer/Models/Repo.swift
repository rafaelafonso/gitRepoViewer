//
//  Repo.swift
//  GitRepoViewer
//
//  Created by Rafael Afonso on 31/10/24.
//

import Foundation

struct Repo: Codable, Hashable, Identifiable, Equatable {

    private enum CodingKeys: String, CodingKey {
        case id, owner, name, language
    }

    let id: Int
    let owner: Owner
    let name: String
    let language: String?

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.owner = try container.decode(Owner.self, forKey: .owner)
        self.name = try container.decode(String.self, forKey: .name)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
    }
}
