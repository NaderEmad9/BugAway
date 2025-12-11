# BugAway Application

<p align="center">
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/general_view/splash.png" alt="BugAway Logo" width="250"/>
</p>

<p align="center">
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"></a>
  <a href="https://dart.dev"><img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"></a>
  <a href="https://firebase.google.com"><img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase"></a>
  <a href="https://bloclibrary.dev"><img src="https://img.shields.io/badge/BLoC-00D1B2?style=for-the-badge&logo=bloc&logoColor=white" alt="BLoC"></a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-iOS%20%7C%20Android-blue?style=flat-square" alt="Platform">
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" alt="License">
  <img src="https://img.shields.io/github/stars/NaderEmad9/BugAway?style=flat-square" alt="Stars">
</p>

---

**BugAway** is a comprehensive Flutter-based mobile application designed to streamline and manage pesticide operations. This app caters to two types of users: **Managers** and **Engineers**, offering powerful tools for managing inventory, assigning locations, creating detailed reports, and facilitating real-time communication.

---

## 📋 Table of Contents

- [Features](#-features)
- [Architecture](#-architecture)
- [Tech Stack](#-tech-stack)
- [Getting Started](#-getting-started)
- [Screenshots](#-screenshots)
- [Project Structure](#-project-structure)
- [Contributing](#-contributions)
- [License](#-license)

---

## ✨ Features

### General Features
- **Account Requests**: Engineers can request accounts; managers can accept or decline these requests.
- **Real-Time Chat**: Instant communication between users with real-time updates.
- **Notifications**: 
  - Mobile notifications for updates.
  - Email notifications for account requests.

### Manager Features
- **User Management**: Add accounts directly or approve/decline requests.
- **Location Assignment**: Assign specific locations to engineers.
- **Inventory Management**: Add, delete, or edit materials in real-time.
- **Report Review**: Review reports submitted by engineers and download them as PDFs if needed.

### Engineer Features
- **Assigned Locations**: View and manage locations assigned by managers.
- **Inventory Access**: Check the availability and quantities of materials.
- **Report Generation**:
  - Create detailed reports for assigned locations, including:
    - Material usage, recommendations, and condition details.
    - Device QR code scanning (if applicable to the location).
    - Attach photos and collect whiteboard signatures.
  - Download reports as PDFs or submit them upon completion.

---

## 🏗️ Architecture

BugAway follows **Clean Architecture** principles, ensuring a scalable, maintainable, and testable codebase.

```
lib/
├── Config/           # App configuration (routes, theme)
├── Core/             # Shared components, utilities, error handling
├── Features/         # Feature modules (each with clean architecture layers)
│   ├── login/
│   │   ├── data/          # Data sources, repositories implementation
│   │   ├── domain/        # Business logic, entities, use cases
│   │   └── presentation/  # UI, Cubit/BLoC state management
│   ├── inventory/
│   ├── chat/
│   └── ...
├── di/               # Dependency Injection setup
└── main.dart         # App entry point
```

### Key Architecture Patterns:
- **Clean Architecture** - Separation of concerns across Data, Domain, and Presentation layers
- **BLoC/Cubit Pattern** - Predictable state management
- **Dependency Injection** - Decoupled and testable code
- **Repository Pattern** - Abstract data sources

---

## 🛠️ Tech Stack

- **Flutter**: Cross-platform framework for app development.
- **Firebase**: Real-time database, authentication, cloud storage, and notifications.
- **Dart**: Programming language for development.
- **State Management**: BLoC/Cubit for predictable state handling.
- **Dependency Injection**: get_it for service locator pattern.
- **Google Fonts**: Enhanced text styling and readability.

### Key Dependencies

| Package | Purpose |
|---------|---------|
| `firebase_core` | Firebase core functionalities |
| `firebase_auth` | User authentication |
| `cloud_firestore` | Real-time database |
| `firebase_storage` | File storage |
| `flutter_bloc` | State management |
| `get_it` | Dependency injection |
| `flutter_local_notifications` | Local notifications |
| `pdf` | PDF generation |
| `qr_flutter` | QR code generation |

---

## 🚀 Getting Started

### Prerequisites

Ensure the following are installed:

- [Flutter](https://flutter.dev/docs/get-started/install) (version 3.0 or later)
- [Dart](https://dart.dev/get-dart)
- Firebase project set up (for backend operations)

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/NaderEmad9/BugAway.git
   ```

2. **Navigate to the Project Directory**

   ```bash
   cd BugAway
   ```

3. **Install Dependencies**

   Run the following command to fetch the required packages:

   ```bash
   flutter pub get
   ```
   
4. **Firebase Setup**

    - Set up Firebase for your project:
     - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/).
     - Follow the instructions to add both Android and iOS Firebase configurations,(or simply choose flutter configuration).
     - Replace `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) in the respective directories, or just use flutter integration provided by Firebase.

   ```bash
   flutter run
   ```
   
5. **Run the Application**

   Use the following command to run the app on your preferred device:

   ```bash
   flutter run
   ```

## 📸 Screenshots

---

### General View

<p align="center">
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/general_view/splash.png" alt="Splash Screen" width="220" style="margin: 10px;"/>
</p>
<p align="center">
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/general_view/choose.png" alt="Choose Option" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/general_view/requesting.png" alt="Requesting" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/general_view/login.png" alt="Login Screen" width="220" style="margin: 10px;"/>
  
</p>
<p align="center">
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/general_view/forget.png" alt="Forgot Password" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/general_view/report.png" alt="Report View" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/general_view/pdf.png" alt="PDF View" width="220" style="margin: 10px;"/>
</p>

---

### Loading and Transition States

<p align="center">
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/general_view/invs.gif" alt="Inventory Loading" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/general_view/reports.gif" alt="Reports Loading" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/general_view/sites.gif" alt="Sites Loading" width="220" style="margin: 10px;"/>
</p>
<p align="center">
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/general_view/users.gif" alt="Users Loading" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/general_view/sending.gif" alt="Sending Animation" width="220" style="margin: 10px;"/>
</p>

---

### Manager View

<p align="center">
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/manager_view/cat.png" alt="Categories" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/manager_view/drawm.png" alt="Draw Manager" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/manager_view/manager_prof.png" alt="Manager Profile" width="220" style="margin: 10px;"/>
</p>
<p align="center">
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/manager_view/add_acc.png" alt="Add Account" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/manager_view/chat.png" alt="Chat Screen" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/manager_view/request.png" alt="Requests" width="220" style="margin: 10px;"/>
</p>
<p align="center">
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/manager_view/invm.png" alt="Inventory Management" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/manager_view/inv_di.png" alt="Inventory Details" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/manager_view/m_sites.png" alt="Manager Sites" width="220" style="margin: 10px;"/>
  
</p>
<p align="center">
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/manager_view/di_site.png" alt="Detailed Site" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/manager_view/users_repos.png" alt="Users" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/manager_view/mv_repos.png" alt="User Report" width="220" style="margin: 10px;"/>
</p>

---

### Engineer View

<p align="center">
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/cat.png" alt="Category" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/drawer.png" alt="Drawer" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/uprof.png" alt="User Profile" width="220" style="margin: 10px;"/>
</p>
<p align="center">
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/chatu.png" alt="Chat" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/inv_us.png" alt="Inventory Usage" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/us_sites.png" alt="Sites" width="220" style="margin: 10px;"/>
</p>
<p align="center">
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/uv_repos.png" alt="UV Report" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/form.png" alt="Form" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/notes.png" alt="Notes" width="220" style="margin: 10px;"/>
  </p>
<p align="center">
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/recommend.PNG" alt="Recommendations" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/conditions.png" alt="Conditions" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/pic.png" alt="Picture" width="220" style="margin: 10px;"/>
</p>
<p align="center">
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/matu.png" alt="Material Usage" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/mats.png" alt="Materials" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/scanned.PNG" alt="Scanned" width="220" style="margin: 10px;"/>
</p>
<p align="center">
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/qr_scan.PNG" alt="QR Scan" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/signs.PNG" alt="Signs" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/BugAway/raw/main/assets/screenshots/engineer_view/sign_pad.PNG" alt="Signature Pad" width="220" style="margin: 10px;"/>
  
</p>

---

## 📂 Project Structure

```
BugAway/
├── android/              # Android native configuration
├── ios/                  # iOS native configuration
├── lib/
│   ├── Config/           # Routes and theme configuration
│   ├── Core/             # Shared utilities, components, error handling
│   ├── Features/         # Feature-based modules
│   │   ├── chat/         # Real-time messaging
│   │   ├── inventory/    # Material management
│   │   ├── login/        # Authentication
│   │   ├── reports/      # Report generation
│   │   └── ...           # Other features
│   ├── di/               # Dependency injection
│   └── main.dart         # Entry point
├── assets/               # Images, fonts, animations
├── test/                 # Unit and widget tests
└── pubspec.yaml          # Dependencies
```

---

## 🤝 Contributions

Contributions are welcome! Feel free to fork this repository, open issues, and submit pull requests.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
