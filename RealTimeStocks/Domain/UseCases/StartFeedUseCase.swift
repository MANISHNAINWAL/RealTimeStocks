//
//  StartFeedUseCase.swift
//  RealTimeStocks
//
//  Created by Manish Nainwal on 28/02/26.
//

public final class StartFeedUseCase {
    
    private let repository: StockRepositoryProtocol
    
    public init(repository: StockRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() {
        repository.start()
    }
}
