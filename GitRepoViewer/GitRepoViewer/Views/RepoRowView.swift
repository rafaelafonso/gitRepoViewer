//
//  RepoRowView.swift
//  GitRepoViewer
//
//  Created by Rafael Afonso on 31/10/24.
//

import SwiftUI

struct RepoRowView: View {
    var repo: Repo

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(repo.name)
                    .font(.system(size: 18, weight: .bold))
                Spacer()
            }
            if let language = repo.language {
                Text(language)
                    .font(.system(size: 18, weight: .light))
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
    }
}

