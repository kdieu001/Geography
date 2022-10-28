//
//  GeographyApp.swift
//  Geography
//
//  Created by Kevin Dieu on 10/10/22.
//

import SwiftUI

fileprivate let urlString = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"

@main
struct GeographyApp: App {
    

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: MainViewModel(urlString: urlString))
        }
    }
}

final class AsyncService {
    func load(completion: @escaping () -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now()+1 ) {
            completion()
        }
    }
}
