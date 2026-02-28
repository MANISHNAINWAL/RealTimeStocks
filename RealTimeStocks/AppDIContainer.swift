//
//  AppDIContainer.swift
//  RealTimeStocks
//
//  Created by Manish Nainwal on 28/02/26.
//

final class AppDIContainer {
    
    private lazy var socket: WebSocketServiceProtocol = WebSocketService()
    
    private lazy var repository: StockRepositoryProtocol =
        StockRepository(socket: socket)
    
    func makeFeedViewModel() -> FeedViewModel {
        FeedViewModel(
            startUseCase: StartFeedUseCase(repository: repository),
            stopUseCase: StopFeedUseCase(repository: repository),
            observeUseCase: ObserveStocksUseCase(repository: repository)
        )
    }
}
