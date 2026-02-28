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
    
    private let startUseCase: StartFeedUseCase
    private let stopUseCase: StopFeedUseCase
    private let observeUseCase: ObserveStocksUseCase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(startUseCase: StartFeedUseCase,
         stopUseCase: StopFeedUseCase,
         observeUseCase: ObserveStocksUseCase) {
        
        self.startUseCase = startUseCase
        self.stopUseCase = stopUseCase
        self.observeUseCase = observeUseCase
        
        bind()
    }
    
    private func bind() {
        observeUseCase.execute()
            .receive(on: DispatchQueue.main)
            .assign(to: &$stocks)
    }
    
    func start() { startUseCase.execute() }
    func stop() { stopUseCase.execute() }
}
