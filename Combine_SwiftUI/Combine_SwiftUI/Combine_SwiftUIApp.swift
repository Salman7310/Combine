//
//  Combine_SwiftUIApp.swift
//  Combine_SwiftUI
//
//  Created by Salman_Macbook on 19/07/25.
//

import SwiftUI

@main
struct Combine_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel())
        }
    }
}
