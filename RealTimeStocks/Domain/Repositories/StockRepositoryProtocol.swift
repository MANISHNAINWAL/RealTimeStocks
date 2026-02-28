//
//  StockRepositoryProtocol.swift
//  RealTimeStocks
//
//  Created by Manish Nainwal on 28/02/26.
//

import Combine

public protocol StockRepositoryProtocol {
    var stocksPublisher: AnyPublisher<[Stock], Never> { get }
    var connectionStatusPublisher: AnyPublisher<Bool, Never> { get }
    func start()
    func stop()
}
