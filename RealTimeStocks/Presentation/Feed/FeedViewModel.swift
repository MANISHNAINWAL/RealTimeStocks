//
//  FeedViewModel.swift
//  RealTimeStocks
//
//  Created by Manish Nainwal on 28/02/26.
//

import Combine
import SwiftUI

@MainActor
final class FeedViewModel: ObservableObject {
    
    @Published private(set) var stocks: [Stock] = []
    @Published private(set) var isConnected: Bool = false
    
    private let observeConnectionUseCase: ObserveConnectionStatusUseCase
    
    private let startUseCase: StartFeedUseCase
    private let stopUseCase: StopFeedUseCase
    private let observeUseCase: ObserveStocksUseCase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(startUseCase: StartFeedUseCase,
         stopUseCase: StopFeedUseCase,
         observeUseCase: ObserveStocksUseCase,
         observeConnectionUseCase: ObserveConnectionStatusUseCase) {
        
        self.startUseCase = startUseCase
        self.stopUseCase = stopUseCase
        self.observeUseCase = observeUseCase
        self.observeConnectionUseCase = observeConnectionUseCase
        
        bind()
    }
    
    private func bind() {
        
        observeUseCase.execute()
            .receive(on: DispatchQueue.main)
            .assign(to: &$stocks)
        
        observeConnectionUseCase.execute()
            .receive(on: DispatchQueue.main)
            .assign(to: &$isConnected)
    }
    
    func start() { startUseCase.execute() }
    func stop() { stopUseCase.execute() }
}
