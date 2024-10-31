//
//  ReposListView.swift
//  GitRepoViewer
//
//  Created by Rafael Afonso on 31/10/24.
//

import SwiftUI

struct ReposListView: View {
    @ObservedObject var viewModel: RepoViewModel
    @State private var owner: Owner?

    init(viewModel: RepoViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    VStack(spacing: 12) {
                        if let avatarURL = owner?.avatarURL {
                            AsyncImage(url: URL(string: avatarURL)) { image in
                                image.image?
                                    .resizable()
                                    .frame(width: 180, height: 180)
                                    .clipShape(Circle())
                            }
                        }
                        else {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        }

                        Text(owner?.username ?? "No name")
                            .font(.system(size: 20))
                    }
                    Spacer()
                }
                .frame(height: 240)
                .background {
                    Color.secondary
                        .opacity(0.2)
                        .ignoresSafeArea()
                }

                Color.gray
                    .frame(height: 1)

                if let repos = viewModel.repos {
                    VStack {
                        ScrollView {
                            ForEach(repos) { repo in
                                RepoRowView(repo: repo)
                                Color.gray
                                    .opacity(0.6)
                                    .frame(height: 1)
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            if let firstRepo = viewModel.repos?.first {
                self.owner = firstRepo.owner
            }
        }
        .onDisappear {
            viewModel.repos = nil
        }
    }
}

#Preview {
    ReposListView(viewModel: RepoViewModel())
}
