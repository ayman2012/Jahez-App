
# 📱 Jahez App

**Jahez App** is a modular, scalable iOS application built with Swift and SwiftUI. It follows best practices in architecture, testing, and configuration management, making it easy to extend, maintain, and deploy across multiple environments.

---

## 🧱 Architecture Overview
![Architecture Overview](/jahez_app_architecture_diagram.png)
The app is structured using the **MVVM (Model-View-ViewModel)** architecture pattern, ensuring a clear separation of concerns:

- **View**: SwiftUI-based UI components observing ViewModels.
- **ViewModel**: Contains presentation logic and binds data for the view.
- **Model**: DTOs and domain entities mapped for UI consumption.
- **Network Layer**: Handles all API interactions, including connectivity and logging.
- **Cache Layer**: Provides persistent and temporary caching support.

---

## 📁 Project Structure

```
Jahez App/
├── Jahez App/
│   ├── Network/
│   │   ├── NetworkManager.swift
│   │   ├── CacheService.swift
│   │   ├── ReachabilityService.swift
│   │   ├── NetworkLogger.swift
│   │   ├── EnvironmentEnum.swift
│   └── Supporting Files/
│       ├── Jahez-App-Info.plist
│       ├── Assets.xcassets/
│       └── Jahez_AppApp.swift
├── Jahez AppTests/
│   └── UnitTestExample.swift
```

---

## 🔁 Data Flow Sequence

![Sequence Diagram](/sequence_diagram.png)

1. `Jahez_AppApp.swift` initializes the app.
2. The root `View` communicates with its `ViewModel`.
3. ViewModel communicates with the Repository 
4- The Repository  check the connectivity, and if connected then performs an API call through  `NetworkManager`
4- If not connected, check `CacheService` for local data.
5. Responses are logged and returned to the ViewModel.
6. ViewModel updates the UI via state bindings.

---

## 🧩 Dependency Flow:

![Dependency Flow](/Dependency_Flow.png)

## Key Architecture Principles:

1- Separation of Concerns: Each class has distinct responsibilities

2- Single Source of Truth: Repository manages data origin (network/cache)

3- Decoupled Components: Services are interchangeable and testable

4- Unidirectional Data Flow: View → ViewModel → Repository → Services

5- Centralized Logging: All components share same logger instance

## 🧪 Unit Testing

Unit tests reside under `Jahez AppTests/` and follow XCTest standards.

---

## ✅ Tools & Practices

- **SwiftLint**: Enforced for consistent code style
- **Xcode Configurations (.xcconfig)**: Used to manage environment-specific settings
- **Caching**: Temporary data cached with `UserDefaults` instead of `NSCache`

---

## 🔧 Suggested Enhancements

- Display toast to show that no connection when loading from cache while offline.
- Decouple DTOs from UI models with proper mapping
- Add full localization support (e.g., English, Arabic)
- Expand test coverage for all critical logic
- Implement dependency injection for better testing
- Automate builds with CI/CD pipelines
- Use `NSCache` instead of `UserDefaults`

---

## 🧰 Requirements

- macOS Ventura or later
- Xcode 15+
- iOS 15.0+
- Swift 5.9+

---

## 🚀 Getting Started

Clone the repository and open the project in Xcode:

```bash
git clone https://github.com/ayman2012/Jahez-App.git
cd jahez-app
open "Jahez App.xcodeproj"
```

Run the app with:

```bash
Cmd + R
```

---

## 🧑‍💻 Author

**Ayman F. Mohammed**  
Senior iOS Engineer  
[LinkedIn →](https://www.linkedin.com/in/aymanfathy)

---

## 📌 License

This project is proprietary and intended for internal use.
