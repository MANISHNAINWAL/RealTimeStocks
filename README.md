# 📈 Real-Time Stocks – SwiftUI

A production-style iOS application built with **SwiftUI**, demonstrating a real-time stock price feed using **WebSocket**, **MVVM**, and **Clean Architecture** principles.

---

## 🚀 Features

- ✅ Real-time stock price updates (simulated via WebSocket echo)
- ✅ Clean Architecture (Presentation / Domain / Data separation)
- ✅ MVVM with reactive state management
- ✅ Combine-based data flow
- ✅ Navigation using `NavigationStack`
- ✅ Connection status indicator (🟢 / 🔴)
- ✅ Dependency Injection (DI Container)
- ✅ Fully testable architecture

---

## 🏗 Architecture Overview

The project follows **Clean Architecture** with strict separation of concerns:

```
Presentation Layer
 ├── Views (SwiftUI)
 ├── ViewModels
 └── UI State

Domain Layer
 ├── Entities (Stock)
 ├── Repository Protocol
 └── UseCases

Data Layer
 ├── Repository Implementation
 ├── WebSocketServiceProtocol
 └── WebSocketService (URLSession-based)
```

### Key Principles

- Business logic lives in **UseCases**
- ViewModel depends only on **UseCases**
- Repository depends on **WebSocket abstraction**
- No tight coupling between layers

---

## 🧠 Tech Stack

- **Swift 5.9+**
- **SwiftUI**
- **Combine**
- **URLSessionWebSocketTask**
- **NavigationStack (iOS 16+)**

---

## 📂 Project Structure

```
RealTimeStocksApp
│
├── App
│   └── RealTimeStocksApp.swift
│
├── Presentation
│   ├── FeedView.swift
│   ├── DetailsView.swift
│   ├── StockRow.swift
│   └── FeedViewModel.swift
│
├── Domain
│   ├── Stock.swift
│   ├── StockRepositoryProtocol.swift
│   └── UseCases
│       ├── ObserveStocksUseCase.swift
│       ├── StartFeedUseCase.swift
│       └── StopFeedUseCase.swift
│
├── Data Layer
|   ├── Repository Implementation
|   ├── WebSocketServiceProtocol
|   └── WebSocketService (URLSession-based)
│
└── DI
    └── AppDIContainer.swift
```

---

## 🔌 How It Works

1. App starts
2. User taps **Start**
3. WebSocket connects to:
   ```
   wss://ws.postman-echo.com/raw
   ```
4. Timer simulates stock price updates
5. Updates are echoed back via WebSocket
6. Repository processes and sorts stocks
7. ViewModel publishes updated list
8. UI updates automatically

---

## 📊 Data Flow

```
WebSocket
   ↓
StockRepository
   ↓
ObserveStocksUseCase
   ↓
FeedViewModel (@Published)
   ↓
SwiftUI View
```

Fully reactive using **Combine**.

---

## 🟢 Connection Status Indicator

The top navigation bar displays:

- 🟢 Connected
- 🔴 Disconnected

Connection state flows from:

```
WebSocketService
   ↓
Repository
   ↓
ObserveConnectionStatusUseCase
   ↓
ViewModel
   ↓
UI
```

---

## 🧪 Unit Testing Ready

You can easily test:

- Repository using mocked WebSocketService
- ViewModel using mocked UseCases
- Connection state behavior
- Sorting logic

Example mock:

```swift
final class MockWebSocketService: WebSocketServiceProtocol {
    var publisher = PassthroughSubject<String, Never>().eraseToAnyPublisher()
    var connectionStatusPublisher = CurrentValueSubject<Bool, Never>(false).eraseToAnyPublisher()
    
    func connect() {}
    func disconnect() {}
    func send(_ message: String) {}
}
```

---

## ▶️ How to Run

1. Open the project in **Xcode 15+**
2. Select an iOS 16+ simulator
3. Run the project
4. Tap **Start**
5. Observe real-time updates

---

## 📱 Screens

- Stock Feed Screen (sorted by price descending)
- Details Screen (symbol, price, direction, description)

---

## 🔮 Possible Improvements

- Auto-reconnect strategy
- Real market API integration
- Pagination for large symbol sets
- Local caching
- Modular architecture (SPM modules)
- Snapshot tests
- Performance optimization for large lists


---

## 👨‍💻 Author

Manish Nainwal  
Senior iOS Developer  
9+ Years Experience  
Banking & FinTech Specialist  

---

## 📄 License

This project is for demonstration and learning purposes.
