//
//  WebSocketServiceProtocol.swift
//  RealTimeStocks
//
//  Created by Manish Nainwal on 27/02/26.
//

import Combine

public protocol WebSocketServiceProtocol {
    var publisher: AnyPublisher<String, Never> { get }
    
    func connect()
    func disconnect()
    func send(_ message: String)
}
