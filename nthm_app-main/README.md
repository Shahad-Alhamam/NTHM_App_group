# NTHM App - Flutter

Welcome to the NTHM Flutter Application! This README provides instructions on how to set up, run, and contribute to the project.

## Table of Contents
- [Project Overview](#project-overview)
- [Getting Started](#getting-started)
- [Setup Instructions](#setup-instructions)
- [Run the App](#run-the-app)
- [State Management](#state-management)
- [Firebase Integration](#firebase-integration)
- [Contributing](#contributing)

## Project Overview
NTHM is a Flutter application utilizing Firebase for backend services and Bloc for state management. It supports cross-platform deployment on Android and iOS.

---

## Getting Started
To get started with the NTHM app, ensure you have the following installed:

- **Flutter SDK** (version 3.24.3 or higher)
- **Android Studio** (version 2024.2 or later)
- **Xcode** (for iOS development, if on macOS)
- **Firebase CLI**
- **A Code Editor** (such as Visual Studio Code or Android Studio)

---

## Setup Instructions
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/Shahad-Alhamam/NTHM_App_group.git
   cd nthm-app
   ```

2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**
   - Create a Firebase project in the Firebase Console.
   - Add Android and iOS apps.
   - Download and place `google-services.json` (for Android) in `android/app/`.
   - Download and place `GoogleService-Info.plist` (for iOS) in `ios/Runner/`.

4. **Set Up Environment Variables:**
   - Create a `.env` file in the root directory with the necessary configuration values.

5. **Run Firebase Emulator (optional):**
   ```bash
   firebase emulators:start
   ```

---

## Run the App
### On Android:
```bash
flutter run --flavor dev -t lib/main_dev.dart
```

### On iOS:
```bash
open ios/Runner.xcworkspace
```
- Select a simulator in Xcode and click **Run**.

### On Web:
```bash
flutter run -d web
```

---

## State Management
The app uses **Bloc** for state management. Each feature has its own Bloc implementation following the best practices of separation of concerns and reactivity.

- **Features:** Organized by modules.
- **Structure:**
  - `bloc/` - Business Logic Components
  - `repositories/` - Repository classes
  - `models/` - Data models
  - `screens/` - UI screens

---

## Firebase Integration
Firebase services integrated include:

- **Authentication** - Sign-in and sign-up with email/password and social providers.
- **Cloud Firestore** - Real-time database services.
- **Firebase Storage** - File uploads.
- **Push Notifications** - Powered by Firebase Cloud Messaging (FCM).

Make sure to enable these services in your Firebase Console.

---

## Contributing
We welcome contributions! Follow these steps:

1. **Fork the Repository.**
2. **Create a New Branch:**
   ```bash
   git checkout -b feature/your-feature
   ```
3. **Commit Changes:**
   ```bash
   git commit -m "Add your feature description"
   ```
4. **Push the Branch:**
   ```bash
   git push origin feature/your-feature
   ```
5. **Create a Pull Request.**

---

Thank you for contributing to NTHM! We appreciate your support.

