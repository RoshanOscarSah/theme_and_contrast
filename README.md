# Theme & Contrast Demo

A Flutter application that demonstrates advanced theme management and accessibility features, including dynamic theme switching, high contrast mode support, and system accessibility detection.

## Features

### 🎨 Theme Management

- **Dynamic Theme Switching**: Toggle between Light, Dark, and System themes
- **Persistent Preferences**: Theme settings are saved and restored across app sessions
- **Real-time Updates**: Theme changes are applied immediately throughout the app
- **System Integration**: Automatically follows system theme preferences

### ♿ Accessibility Support

- **High Contrast Mode**: Built-in high contrast themes for better accessibility
- **System Detection**: Automatically detects system high contrast settings on Android
- **Manual Override**: Users can manually enable/disable high contrast mode
- **Platform-Specific**: Different detection methods for Android and iOS

### 🎯 Design System

- **Custom Color Palette**: Extended color scheme with additional colors (Yellow, Brown, Emerald)
- **Consistent Styling**: Unified design system across all components
- **Performance Optimized**: Cached theme data for better performance
- **Responsive Design**: Adapts to different screen sizes and orientations

## Architecture

### Core Components

#### Theme Management (`lib/core/theme/`)

- **ThemeManager**: Central theme management with listener pattern
- **ThemeInheritedWidget**: Provides theme context throughout the widget tree
- **ContrastManager**: Handles high contrast detection and management
- **Theme Types**: Separate theme definitions for light, dark, and high contrast modes

#### Storage (`lib/core/persistant_storage/`)

- **GetStorage**: Persistent storage for theme preferences
- **ThemePreferences**: Manages saving/loading of theme settings

#### Lifecycle Management (`lib/core/lifecycle/`)

- **AppWrapper**: Handles app lifecycle events
- **AppLifecycleHandler**: Manages app state changes

### Platform Integration

#### Android (`android/app/src/main/kotlin/`)

- **MainActivity**: Native Android implementation for accessibility detection
- **Method Channel**: Communication bridge between Flutter and native Android code
- **Multiple Detection Methods**: Various approaches to detect system high contrast settings

## Getting Started

### Prerequisites

- Flutter SDK (^3.7.2)
- Dart SDK
- Android Studio / VS Code
- Android SDK (for Android development)
- Xcode (for iOS development, macOS only)

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd theme_and_contrast
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Dependencies

- **flutter**: Core Flutter framework
- **cupertino_icons**: iOS-style icons
- **get_storage**: Persistent storage solution

## Usage

### Theme Switching

- Use the "Switch Theme" button to cycle through Light → Dark → System themes
- Access detailed theme settings via the palette icon in the app bar

### Contrast Mode

- Use the "Toggle Contrast" button to switch between Normal and High contrast modes
- The app automatically detects system high contrast settings
- Manual override available in the appearance modal

### Appearance Settings

- Tap the palette icon in the app bar to open the appearance modal
- Configure theme and contrast preferences
- Settings are automatically saved and persisted

## Platform Support

### Android

- Full high contrast detection support
- Multiple detection methods for different Android versions
- Native accessibility settings integration
- Debug logging for accessibility settings

### iOS

- Basic high contrast detection via Flutter's MediaQuery
- System theme integration
- Native iOS appearance support

### Web/Desktop

- Theme switching support
- High contrast mode (manual only)
- Responsive design

## Development

### Project Structure

```
lib/
├── core/
│   ├── lifecycle/          # App lifecycle management
│   ├── persistant_storage/ # Data persistence
│   ├── theme/             # Theme management system
│   └── utils/             # Utility functions
├── screens/
│   ├── home_page.dart     # Main app screen
│   └── widgets/           # Reusable UI components
└── main.dart              # App entry point
```

### Key Files

- `lib/main.dart`: App initialization and theme setup
- `lib/screens/home_page.dart`: Main UI with theme demonstration
- `lib/core/theme/manager/theme_manager.dart`: Core theme management logic
- `android/app/src/main/kotlin/MainActivity.kt`: Android accessibility detection

### Performance Features

- **Theme Caching**: Cached theme data for better performance
- **Performance Monitoring**: Built-in performance tracking
- **Efficient Rebuilds**: Minimal widget rebuilds on theme changes
- **Memory Management**: Proper listener cleanup and disposal

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the excellent framework
- Material Design team for design inspiration
- Accessibility community for guidance on inclusive design
