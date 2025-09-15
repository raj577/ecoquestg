# Eco Quiz Kids - Setup Guide

This guide will help you set up and run the Eco Quiz Kids Flutter app on your development environment.

## Prerequisites

Before you begin, ensure you have the following installed:

### 1. Flutter SDK
- **Version**: 3.10.0 or higher
- **Download**: [Flutter Official Website](https://flutter.dev/docs/get-started/install)
- **Verify Installation**: Run `flutter doctor` in terminal

### 2. Development Environment
Choose one of the following:

#### Option A: Android Studio (Recommended)
- Download from [Android Studio](https://developer.android.com/studio)
- Install Flutter and Dart plugins
- Configure Android SDK

#### Option B: Visual Studio Code
- Download from [VS Code](https://code.visualstudio.com/)
- Install Flutter extension
- Install Dart extension

### 3. Device Setup

#### For Android Testing:
- Enable Developer Options on your Android device
- Enable USB Debugging
- Or use Android Emulator from Android Studio

#### For iOS Testing (Mac only):
- Xcode 12.0 or higher
- iOS Simulator or physical iOS device
- Apple Developer account (for device testing)

## Installation Steps

### Step 1: Get the Project Files
```bash
# If you have the project as a zip file, extract it
# Navigate to the project directory
cd eco_quiz_app
```

### Step 2: Install Dependencies
```bash
# Install Flutter packages
flutter pub get
```

### Step 3: Verify Setup
```bash
# Check if Flutter is properly configured
flutter doctor

# Check for connected devices
flutter devices
```

### Step 4: Run the App
```bash
# Run on connected device/emulator
flutter run

# Or run in debug mode
flutter run --debug

# Or run in release mode
flutter run --release
```

## Project Structure Overview

```
eco_quiz_app/
├── lib/                      # Dart source code
│   ├── main.dart            # App entry point
│   ├── models/              # Data models
│   ├── screens/             # App screens
│   ├── widgets/             # Reusable widgets
│   └── utils/               # Utility functions
├── assets/                  # App assets
│   └── images/              # Quiz images
├── android/                 # Android-specific files
├── ios/                     # iOS-specific files
├── pubspec.yaml            # Dependencies and configuration
└── README.md               # Project documentation
```

## Troubleshooting

### Common Issues and Solutions

#### 1. "Flutter command not found"
**Solution**: Add Flutter to your PATH environment variable
```bash
# Add to your shell profile (.bashrc, .zshrc, etc.)
export PATH="$PATH:[PATH_TO_FLUTTER_GIT_DIRECTORY]/flutter/bin"
```

#### 2. "No connected devices"
**Solutions**:
- For Android: Enable USB Debugging and connect device
- For iOS: Open Simulator from Xcode
- Use `flutter emulators` to see available emulators

#### 3. "Gradle build failed" (Android)
**Solutions**:
- Update Android SDK and build tools
- Clean and rebuild: `flutter clean && flutter pub get`
- Check Android SDK path in Android Studio

#### 4. "CocoaPods not installed" (iOS)
**Solution**:
```bash
# Install CocoaPods
sudo gem install cocoapods
cd ios
pod install
```

#### 5. "Assets not found"
**Solution**:
- Ensure all image files are in `assets/images/` directory
- Run `flutter pub get` after adding new assets
- Check `pubspec.yaml` for correct asset paths

### Performance Tips

#### For Better Development Experience:
1. **Hot Reload**: Use `r` in terminal while app is running
2. **Hot Restart**: Use `R` in terminal while app is running
3. **Debug Mode**: Use for development with better error messages
4. **Release Mode**: Use for performance testing

#### For Better App Performance:
1. **Optimize Images**: Ensure images are appropriately sized
2. **Use Release Mode**: For final testing and distribution
3. **Profile Mode**: Use `flutter run --profile` for performance analysis

## Building for Distribution

### Android APK
```bash
# Build APK
flutter build apk

# Build App Bundle (recommended for Play Store)
flutter build appbundle
```

### iOS App
```bash
# Build for iOS (Mac only)
flutter build ios
```

## Development Workflow

### 1. Making Changes
- Edit Dart files in `lib/` directory
- Add new images to `assets/images/`
- Update `pubspec.yaml` if adding new dependencies

### 2. Testing Changes
- Use hot reload (`r`) for quick UI changes
- Use hot restart (`R`) for logic changes
- Test on different screen sizes and orientations

### 3. Adding New Features
- Follow the existing project structure
- Add new screens to `screens/` directory
- Create reusable widgets in `widgets/` directory
- Update quiz data in `utils/quiz_data.dart`

## Customization Guide

### Adding New Quiz Questions
1. Open `lib/utils/quiz_data.dart`
2. Add new `QuizQuestion` objects to the list
3. Create corresponding images and add to `assets/images/`
4. Update `pubspec.yaml` if needed

### Changing App Colors
1. Open `lib/main.dart`
2. Modify the `ColorScheme` in the theme
3. Update gradient colors in individual screens

### Adding New Categories
1. Add category data in `quiz_data.dart`
2. Create category-specific questions
3. Add category icon and colors in `category_screen.dart`

## Support

If you encounter issues:
1. Check the [Flutter Documentation](https://flutter.dev/docs)
2. Run `flutter doctor` to diagnose setup issues
3. Check the project's README.md for additional information
4. Ensure all dependencies are properly installed

---

**Happy Coding! 🚀**

*This app is designed to make environmental education fun and engaging for children. Enjoy building and customizing it!*

