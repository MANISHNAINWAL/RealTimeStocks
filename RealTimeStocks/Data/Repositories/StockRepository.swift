//
//  StockRepository.swift
//  RealTimeStocks
//
//  Created by Manish Nainwal on 28/02/26.
//

import Combine
import Foundation

final class StockRepository: StockRepositoryProtocol {
    
    private let socket: WebSocketServiceProtocol
    private var stocks: [Stock] = []
    private let subject = CurrentValueSubject<[Stock], Never>([])
    
    private var cancellables = Set<AnyCancellable>()
    private var timer: AnyCancellable?
    
    var stocksPublisher: AnyPublisher<[Stock], Never> {
        subject.eraseToAnyPublisher()
    }
    
    var connectionStatusPublisher: AnyPublisher<Bool, Never> {
        socket.connectionStatusPublisher
    }
    
    init(socket: WebSocketServiceProtocol) {
        self.socket = socket
        setupStocks()
        bindSocket()
    }
    
    func start() {
        socket.connect()
        
        timer = Timer.publish(every: 2, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.generateRandomUpdates()
            }
    }
    
    func stop() {
        timer?.cancel()
        socket.disconnect()
    }
}
private extension StockRepository {
    
    func setupStocks() {
        let symbols = [
            "AAPL","GOOG","TSLA","AMZN","MSFT",
            "NVDA","META","NFLX","BABA","ORCL",
            "INTC","AMD","UBER","SHOP","PYPL",
            "CRM","ADBE","QCOM","TXN","AVGO",
            "COST","PEP","KO","WMT","DIS"
        ]
        
        stocks = symbols.map {
            Stock(
                id: $0,
                symbol: $0,
                description: "\($0) publicly traded company.",
                price: Double.random(in: 100...500)
            )
        }
        
        subject.send(stocks)
    }
    
    func bindSocket() {
        
        socket.publisher
            .sink { [weak self] message in
                self?.handleMessage(message)
            }
            .store(in: &cancellables)
    }
    
    func generateRandomUpdates() {
        for stock in stocks {
            let newPrice = stock.price + Double.random(in: -5...5)
            let payload = "\(stock.symbol):\(newPrice)"
            socket.send(payload)
        }
    }
    
    func handleMessage(_ message: String) {
        let parts = message.split(separator: ":")
        guard parts.count == 2,
              let price = Double(parts[1]) else { return }
        
        let symbol = String(parts[0])
        
        guard let index = stocks.firstIndex(where: { $0.symbol == symbol }) else { return }
        
        stocks[index].previousPrice = stocks[index].price
        stocks[index].price = price
        
        stocks.sort { $0.price > $1.price }
        
        subject.send(stocks)
    }
}
