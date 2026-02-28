//
//  Stock.swift
//  RealTimeStocks
//
//  Created by Manish Nainwal on 27/02/26.
//

import Foundation

public struct Stock: Identifiable, Equatable,Hashable{
    public let id: String
    public let symbol: String
    public let description: String
    public var price: Double
    public var previousPrice: Double?
    
    public init(id: String,
                symbol: String,
                description: String,
                price: Double,
                previousPrice: Double? = nil) {
        self.id = id
        self.symbol = symbol
        self.description = description
        self.price = price
        self.previousPrice = previousPrice
    }
    
    public var change: Double {
        guard let previousPrice else { return 0 }
        return price - previousPrice
    }
    
    public var isPositive: Bool {
        change >= 0
    }
}
