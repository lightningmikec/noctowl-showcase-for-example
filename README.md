# 📸 light-corpuz's (Exam Project)

An iOS sample project built as part of a technical exam.  
The app demonstrates fetching and displaying photos from a public API (Unsplash), with modern SwiftUI architecture, infinite scroll, pull-to-refresh, navigation, and testing.

---

## ✨ Features

- **SwiftUI Instagram-style feed**
  - Photos with username, profile image, upload date, and likes
  - Pull to refresh (`.refreshable`)
  - Infinite scroll / pagination
  - Full-screen image viewer with pinch & double-tap zoom
- **Navigation**
  - `NavigationStack` with inline titles
  - Bottom tab bar: **Exam** (feed) and **Profile**
  - Profile tab shows personal details + a dry-humor `UICollectionView` demo
- **Architecture**
  - MVVM (`DashboardViewModel`)
  - Repository pattern (`PhotosRepository`, `DefaultPhotosRepository`)
  - Fixture-based data for testing
- **Testing**
  - ✅ **Swift Testing (`import Testing`)**
  - Tests for JSON decoding, repository behavior, and `DashboardViewModel`
  - Uses JSON fixtures for realistic test data
- **Humor**
  - Profile tab displays: *“In case you don’t know this is a UICollectionView”* 🤭

---

## 🛠️ Tech Stack

- **Language:** Swift 5.9+
- **Frameworks:** SwiftUI, Combine, Foundation
- **Architecture:** MVVM + Repository
- **Testing:** [Swift Testing](https://developer.apple.com/documentation/testing) (`@Test`, `#expect`)

---

## 📂 Project Structure

```
light-corpuz/
├── Sources/
│   ├── DashboardView.swift
│   ├── DashboardViewModel.swift
│   ├── PhotosRepository.swift
│   ├── DefaultPhotosRepository.swift
│   ├── Models/Photo.swift
│   └── Services/PhotosService.swift
├── Tests/
│   ├── Fixtures/
│   │   └── photos_fixture.json
│   ├── PhotoDecodingTests.swift
│   ├── DefaultPhotosRepositoryTests.swift
│   └── DashboardViewModelTests.swift
└── README.md
```

---

## 📸 Screenshots

*(Add simulator screenshots here — e.g., Exam feed, Profile tab with UICollectionView, Fullscreen image.)*

---

## 🚀 Getting Started

1. Clone the repo:
   ```bash
   git clone https://github.com/your-username/light-corpuz.git
   cd light-corpuz
   ```
2. Open `light-corpuz.xcodeproj` in Xcode.
3. Add an Unsplash API key if required (or continue with fixture data).
4. Run the app on iPhone simulator or device.

---

## ✅ Test Coverage

Run tests with **Product → Test** in Xcode, or from command line:

```bash
swift test
```

Tests included:
- **PhotoDecodingTests**: validates fixture decoding
- **DefaultPhotosRepositoryTests**: verifies pagination & stop conditions
- **DashboardViewModelTests**: success, error, refresh, and pagination logic

---

## 💡 Notes

- Project originally asked for `UICollectionView`.  
  → Implemented as a playful demo in the **Profile tab**, while the main feed is in **modern SwiftUI**.  
- Added **Swift Testing** to show familiarity with Apple’s newest testing framework.

---

## 👤 Author

Michael Allan "Light" Corpuz  
[@lightningowltech](https://github.com/lightningmikec)
