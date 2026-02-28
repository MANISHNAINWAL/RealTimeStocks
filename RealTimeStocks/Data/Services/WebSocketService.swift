//
//  WebSocketService.swift
//  RealTimeStocks
//
//  Created by Manish Nainwal on 27/02/26.
//

import Foundation
import Combine

final class WebSocketService: WebSocketServiceProtocol {
    
    private var task: URLSessionWebSocketTask?
    private let subject = PassthroughSubject<String, Never>()
    private let connectionSubject = CurrentValueSubject<Bool, Never>(false)
    
    private let url = URL(string: "wss://ws.postman-echo.com/raw")!
    
    var publisher: AnyPublisher<String, Never> {
        subject.eraseToAnyPublisher()
    }
    
    var connectionStatusPublisher: AnyPublisher<Bool, Never> {
        connectionSubject.eraseToAnyPublisher()
    }
    
    func connect() {
        guard task == nil else { return }
        
        task = URLSession.shared.webSocketTask(with: url)
        task?.resume()
        
        connectionSubject.send(true)   // 🔥 connected
        receive()
    }
    
    func disconnect() {
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
        connectionSubject.send(false)  // 🔥 disconnected
    }
    
    func send(_ message: String) {
        task?.send(.string(message)) { error in
            if let error = error {
                print("WebSocket send error:", error)
            }
        }
    }
    
    private func receive() {
        task?.receive { [weak self] result in
            switch result {
            case .success(let message):
                if case .string(let text) = message {
                    self?.subject.send(text)
                }
            case .failure:
                self?.connectionSubject.send(false)
            }
            
            self?.receive()
        }
    }
}
