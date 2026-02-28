//
//  DetailsView.swift
//  RealTimeStocks
//
//  Created by Manish Nainwal on 28/02/26.
//

import SwiftUI

struct DetailsView: View {
    
    let symbol: String
    @ObservedObject var viewModel: FeedViewModel
    
    private var stock: Stock? {
        viewModel.stocks.first(where: { $0.symbol == symbol })
    }
    
    var body: some View {
        Group {
            if let stock {
                VStack(spacing: 20) {
                    
                    Text(stock.symbol)
                        .font(.largeTitle)
                    
                    Text(String(format: "%.2f", stock.price))
                        .font(.title)
                    
                    Text(stock.isPositive ? "↑ Up" : "↓ Down")
                        .foregroundColor(stock.isPositive ? .green : .red)
                    
                    Text(stock.description)
                        .padding()
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle(symbol)
    }
}
