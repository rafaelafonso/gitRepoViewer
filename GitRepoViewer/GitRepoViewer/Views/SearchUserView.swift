//
//  SearchUserView.swift
//  GitRepoViewer
//
//  Created by Rafael Afonso on 31/10/24.
//

import SwiftUI

struct SearchUserView: View {

    @StateObject var viewModel: RepoViewModel = RepoViewModel()

    var body: some View {
        VStack {
            Text("test")
        }
        .onAppear {
            viewModel.fetchRepos(from: "rafaelafonso")
        }
    }
}

