//
//  ContentView.swift
//  Combine_SwiftUI
//
//  Created by Salman_Macbook on 19/07/25.
//

//
//  ContentView.swift
//  Combine_SwiftUI
//
//  Created by Salman_Macbook on 19/07/25.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State private var searchText = ""
    @State private var selectedUserId: Int?
    
    var filteredPosts: [Post] {
        if searchText.isEmpty {
            return viewModel.posts
        } else {
            return viewModel.posts.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.body.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    ForEach(filteredPosts) { post in
                        NavigationLink(destination: PostDetailView(post: post)) {
                            PostRowView(post: post)
                        }
                    }
                }
            }
            .navigationTitle("Posts")
            .searchable(text: $searchText, prompt: "Search posts")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    // Refresh button
                    Button(action: {
                        viewModel.getPosts()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                    
                    // Filter button (could be expanded with a menu)
                    Button(action: {
                        // Implement filter logic here
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                    
                    // Settings button
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape")
                    }
                }
                
                // For iPad or macOS, you might want bottom toolbar items
                ToolbarItemGroup(placement: .bottomBar) {
                    Text("\(filteredPosts.count) posts")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .onAppear {
            if viewModel.posts.isEmpty {
                viewModel.getPosts()
            }
        }
    }
}

struct PostRowView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(post.title)
                .font(.headline)
                .lineLimit(1)
            
            Text(post.body)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            HStack {
                Text("User \(post.userId)")
                    .font(.caption)
                    .foregroundColor(.blue)
                
                Spacer()
                
                Text("#\(post.id)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}

struct PostDetailView: View {
    let post: Post
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(post.title)
                        .font(.title2)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Content")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(post.body)
                        .font(.body)
                }
                
                Divider()
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("User ID")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(post.userId)")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Post ID")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(post.id)")
                            .font(.subheadline)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Post Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView: View {
    var body: some View {
        Form {
            Section("Appearance") {
                Toggle("Dark Mode", isOn: .constant(false))
                Picker("Font Size", selection: .constant(1)) {
                    Text("Small").tag(0)
                    Text("Medium").tag(1)
                    Text("Large").tag(2)
                }
            }
            
            Section("About") {
                Text("Version 1.0")
                Text("Combine SwiftUI Demo")
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    ContentView()
}
