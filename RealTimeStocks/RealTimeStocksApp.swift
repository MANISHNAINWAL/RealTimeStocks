//
//  RealTimeStocksApp.swift
//  RealTimeStocks
//
//  Created by Manish Nainwal on 27/02/26.
//

import SwiftUI

@main
struct RealTimeStocksApp: App {
    
    private let container = AppDIContainer()
    
    var body: some Scene {
        WindowGroup {
            FeedView(
                viewModel: container.makeFeedViewModel()
            )
        }
    }
}
