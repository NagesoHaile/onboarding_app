# Onboarding App

A modern Flutter application that helps users set up their profiles with a beautiful and intuitive interface. The app follows clean architecture principles and implements BLoC pattern for state management.

## Download

### Android
- [Download APK](build/app/outputs/flutter-apk/app-release.apk)

### iOS
- [Download IPA](build/app/outputs/ios/app-release.ipa)

## Features

- **Profile Setup**: Interactive form to collect user information
- **Goal Selection**: Choose from predefined goals
- **Interest Selection**: Select multiple interests (2-3)
- **Animated UI**: Smooth transitions and loading states
- **Error Handling**: User-friendly error messages
- **Responsive Design**: Works across different screen sizes

## Architecture

The project follows Clean Architecture principles with the following structure:

```
lib/
├── core/
│   ├── di/              # Dependency injection
│   ├── router_config/   # Navigation configuration
│   └── theme/          # App theme configuration
├── features/
│   └── profile/
│       ├── data/
│       │   ├── models/      # Data models
│       │   ├── repositories/ # Repository implementations
│       │   └── services/    # API services
│       ├── domain/
│       │   ├── repositories/ # Repository interfaces
│       │   └── use_cases/   # Business logic
│       └── presentation/
│           ├── blocs/       # State management
│           └── pages/       # UI screens
└── main.dart
```

## State Management

The app uses the BLoC (Business Logic Component) pattern for state management:
- `ProfileBloc`: Manages profile setup states
- States: Initial, Loading, Complete, Failed
- Events: SetupProfile

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK (latest version)
- Android Studio / VS Code

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/onboarding_app.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Dependencies

- **flutter_bloc**: State management
- **go_router**: Navigation
- **get_it**: Dependency injection
- **equatable**: Value equality

## UI Components

### Profile Setup Page
- Animated form with validation
- Interactive goal selection
- Multi-select interests
- Loading states with animations
- Success/Error feedback

### Dialog & Snackbar
- Animated success dialog with icon
- Custom error snackbar with icon
- Smooth transitions

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the amazing framework
- BLoC pattern for state management
- Clean Architecture principles
