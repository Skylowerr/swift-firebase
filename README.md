# 🔥 FirebaseSecond

> A SwiftUI + Firebase sample project for user authentication and Firestore data management.

![Swift](https://img.shields.io/badge/Swift-5.9+-FA7343?style=for-the-badge&logo=swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-16+-000000?style=for-the-badge&logo=apple&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-12.9.0-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Xcode](https://img.shields.io/badge/Xcode-15+-147EFB?style=for-the-badge&logo=xcode&logoColor=white)

---

## 📋 Table of Contents

- [Features](#-features)
- [Requirements](#-requirements)
- [Installation](#-installation)
- [Firebase Configuration](#-firebase-configuration)
- [Project Structure](#-project-structure)
- [Dependencies](#-dependencies)
- [Running the App](#-running-the-app)
- [Security & Privacy](#-security--privacy)
- [Troubleshooting](#-troubleshooting)

---

## ✨ Features

- 🔐 **Firebase Authentication** — Email/password and Google Sign-In support
- 🗄️ **Cloud Firestore** — User data persistence via `DBUser` model and `UserManager` flows
- ⚡ **Swift Concurrency** — Full `async/await` usage, no completion handlers
- 🧩 **MVVM Architecture** — Clean, testable, and scalable code structure
- 🍎 **SwiftUI** — Modern declarative UI built from the ground up

---

## 🛠 Requirements

| Tool | Minimum Version |
|------|----------------|
| Xcode | 15+ |
| iOS Deployment Target | 16+ |
| Swift | 5.9+ |
| Firebase Project | Firestore & Authentication enabled |

---

## 🚀 Installation

### 1. Clone the repository

```bash
git clone https://github.com/your-username/FirebaseSecond.git
cd FirebaseSecond
```

### 2. Open in Xcode

```bash
open FirebaseSecond.xcodeproj
```

> Swift Package Manager will automatically resolve and download all dependencies when Xcode opens.

### 3. Add your `GoogleService-Info.plist`

Download the `GoogleService-Info.plist` file from your Firebase Console and add it to the **Support** group in the project navigator.  
This file is excluded from version control via `.gitignore` — **never commit it.**

---

## 🔧 Firebase Configuration

1. Go to the [Firebase Console](https://console.firebase.google.com) and create a new project.
2. Under **Authentication**, enable the following sign-in methods:
   - Email / Password
   - Google
3. Under **Firestore Database**, create a database (you can start in test mode).
4. Register your iOS app and download the `GoogleService-Info.plist` file.

---

## 📁 Project Structure

```
FirebaseSecond/
├── Core/
│   └── Authentication/
│       ├── Subviews/
│       │   ├── SignInEmailView.swift
│       │   └── SignInEmailViewModel.swift
│       ├── AuthenticationManager.swift
│       ├── AuthenticationViewModel.swift
│       └── SignInGoogleHelper.swift
├── Firestore/
│   └── UserManager.swift          # Firestore CRUD operations
├── Profile/
│   └── ProfileView.swift
├── Settings/
│   └── AuthenticationView.swift
├── View/
│   └── MainView.swift
├── Utilities/
│   └── Utilities.swift
├── Support/
│   ├── FirebaseSecondApp.swift    # @main entry point
│   ├── Assets.xcassets
│   └── GoogleService-Info.plist  # Not Committed
└── RootView.swift
```

---

## 📦 Dependencies

All dependencies are managed via **Swift Package Manager**.

| Package | Version |
|---------|---------|
| Firebase (Firestore, Auth, AppCheck) | 12.9.0 |
| GoogleSignIn | 9.1.0 |
| GTMAppAuth | 5.0.0 |
| AppAuth | 2.0.0 |
| AppCheck | 11.2.0 |
| GoogleAppMeasurement | 12.8.0 |
| GoogleDataTransport | 10.1.0 |
| GoogleUtilities | 8.1.0 |
| gRPC | 1.69.1 |
| abseil | 1.2024072200.0 |

---

## ▶️ Running the App

1. Make sure `GoogleService-Info.plist` is placed inside the **Support** group.
2. Select a simulator or a physical device running iOS 16+ in Xcode.
3. Press `Cmd + R` to build and run.

---

## 🔒 Security & Privacy

- `GoogleService-Info.plist` must **never** be committed to version control.
- Review your Firestore security rules before moving to production.
- Manage API keys and sensitive configuration using environment variables or `.xcconfig` files.

Recommended `.gitignore` entries:

```
GoogleService-Info.plist
*.xcconfig
Secrets/
```

---

## 🐛 Troubleshooting

**`GoogleService-Info.plist` not found error**  
→ Make sure the file is added to the project with the correct target membership.

**Google Sign-In not working**  
→ Verify that the OAuth 2.0 redirect URL is added to your `Info.plist` as a URL scheme.

**Cannot write to Firestore**  
→ Check your Firestore security rules in the Firebase Console. For development, you can temporarily use:
```
allow read, write: if request.auth != null;
```

**SPM packages not downloading**  
→ Try **Xcode → File → Packages → Reset Package Caches**.

---
