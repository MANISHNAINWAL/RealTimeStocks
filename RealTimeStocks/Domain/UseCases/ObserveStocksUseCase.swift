//
//  ObserveStocksUseCase.swift
//  RealTimeStocks
//
//  Created by Manish Nainwal on 28/02/26.
//

import Combine

public final class ObserveStocksUseCase {
    
    private let repository: StockRepositoryProtocol
    
    public init(repository: StockRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() -> AnyPublisher<[Stock], Never> {
        repository.stocksPublisher
    }
}
