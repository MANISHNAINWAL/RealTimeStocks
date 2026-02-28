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
    private let url = URL(string: "wss://ws.postman-echo.com/raw")!
    
    var publisher: AnyPublisher<String, Never> {
        subject.eraseToAnyPublisher()
    }
    
    func connect() {
        guard task == nil else { return }
        
        task = URLSession.shared.webSocketTask(with: url)
        task?.resume()
        receive()
    }
    
    func disconnect() {
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
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
                switch message {
                case .string(let text):
                    self?.subject.send(text)
                default:
                    break
                }
            case .failure(let error):
                print("WebSocket receive error:", error)
            }
            
            self?.receive()
        }
    }
}
