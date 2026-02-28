//
//  FeedView.swift
//  RealTimeStocks
//
//  Created by Manish Nainwal on 28/02/26.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel: FeedViewModel
    @State private var isRunning = false
    
    var body: some View {
        NavigationStack {
            List(viewModel.stocks) { stock in
                NavigationLink(value: stock.symbol) {
                    StockRow(stock: stock)
                }
            }
            .navigationTitle("Stocks")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Text(viewModel.isConnected ? "🟢" : "🔴")
                            .font(.subheadline)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isRunning ? "Stop" : "Start") {
                        isRunning.toggle()
                        isRunning ? viewModel.start() : viewModel.stop()
                    }
                }
            }
            .navigationDestination(for: String.self) { symbol in
                DetailsView(symbol: symbol, viewModel: viewModel)
            }
        }
    }
}
