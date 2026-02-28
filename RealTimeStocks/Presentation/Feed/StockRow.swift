//
//  StockRow.swift
//  RealTimeStocks
//
//  Created by Manish Nainwal on 28/02/26.
//

import SwiftUI

struct StockRow: View {
    let stock: Stock
    
    var body: some View {
        HStack {
            Text(stock.symbol)
                .font(.headline)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(String(format: "%.2f", stock.price))
                Text(stock.isPositive ? "↑" : "↓")
                    .foregroundColor(stock.isPositive ? .green : .red)
            }
        }
    }
}
