//
//  WebSocketService.swift
//  RealTimeStocks
//
//  Created by Manish Nainwal on 27/02/26.
//

import Foundation
import Combine

class WebSocketService{
    
    private var task: URLSessionWebSocketTask?
    
    private let url = URL(string: "wss://ws.postman-echo.com/raw")!
    
    func connect() {
        guard task == nil else { return }
        
        task = URLSession.shared.webSocketTask(with: url)
        task?.resume()
    }
    
    
    func disconnect() {
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
    }
    
}
