//
//  Model.swift
//  Combine_SwiftUI
//
//  Created by Salman_Macbook on 19/07/25.
//

import Foundation

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
