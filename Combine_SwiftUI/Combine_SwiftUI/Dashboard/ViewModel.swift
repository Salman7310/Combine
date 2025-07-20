//
//  ViewModel.swift
//  Combine_SwiftUI
//
//  Created by Salman_Macbook on 19/07/25.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    
    private var cancellable = Set<AnyCancellable>()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func getPosts() {
        isLoading = true
        errorMessage = nil
        NetworkManager.shared.getData(endpoint: .posts, type: Post.self)
            .sink { completion in   // by using sink we subscribe publisher.
                switch completion {
                case .failure(let error):
                    print("Error is \(error.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] postsData in
                self?.posts = postsData
            }
            .store(in: &cancellable)
        isLoading = false
    }
    
}
