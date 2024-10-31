//
//  HomeView.swift
//  GitRepoViewer
//
//  Created by Rafael Afonso on 31/10/24.
//

import SwiftUI

struct HomeView: View {

    @StateObject var viewModel: RepoViewModel = RepoViewModel()
    @State private var username: String = ""
    @State private var showErrorMessage: Bool = false
    @State private var showUserNotFoundMessage: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text("GitHub Viewer")
                        .font(.system(size: 22))
                        .foregroundStyle(Color.primary)
                    Spacer()
                }
                .frame(height: 50)
                .background {
                    Color.secondary
                        .opacity(0.2)
                        .ignoresSafeArea()
                }

                Color.gray
                    .frame(height: 1)
            }

            Spacer()

            VStack(spacing: 28) {

                // textfield
                TextField("Username", text: $username)
                    .textInputAutocapitalization(.never)
                    .font(.system(size: 20))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.secondary.opacity(0.2))
                            .stroke(Color.secondary.opacity(0.4), lineWidth: 1)
                    }

                // search button
                Button {
                    if !username.isEmpty {
                        viewModel.fetchRepos(from: username)
                    }
                } label: {
                    Text("Search")
                        .font(.system(size: 24))
                        .foregroundStyle(Color.accentColor)
                }
            }
            .padding(.horizontal, 20)

            Spacer()
        }
        .onChange(of: viewModel.genericError) { oldValue, newValue in
            if !oldValue && newValue, let repoError = viewModel.repoError {
                self.showErrorMessage = true
                self.errorMessage = repoError.message
            }
        }
        .onChange(of: viewModel.userNotFound) { oldValue, newValue in
            if !oldValue && newValue, let repoError = viewModel.repoError {
                self.showErrorMessage = true
                self.errorMessage = repoError.message
            }
        }
        .alert("", isPresented: $showErrorMessage) {} message: {
            Text(self.errorMessage)
        }
    }
}

#Preview {
    HomeView()
}

