//
//  ObserveConnectionStatusUseCase.swift
//  RealTimeStocks
//
//  Created by Manish Nainwal on 01/03/26.
//
import Combine

public final class ObserveConnectionStatusUseCase {
    
    private let repository: StockRepositoryProtocol
    
    public init(repository: StockRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() -> AnyPublisher<Bool, Never> {
        repository.connectionStatusPublisher
    }
}
