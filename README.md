# Foody

Foody is a modern food delivery app built with Flutter. It allows users to browse, order, and track food from their favorite restaurants with a beautiful and intuitive interface.

## Features
- Onboarding and authentication (login/register)
- Home screen with product listing
- Food detail and search screens
- Cart management and checkout
- Real-time order tracking and order history
- Multiple payment methods
- Profile management (edit profile, addresses, payment methods)
- Favorites and notifications
- Settings, help & support, about

## Project Structure
```
lib/
  core/         # Core services (auth, cart, product), API client, routing
  models/       # Data models (Product, Category, etc.)
  screens/      # UI screens for each feature
  viewmodels/   # State management using GetX
  widgets/      # Reusable UI components
  constants/    # App-wide constants (colors, text styles)
  utils/        # Helpers and sample data
assets/         # Images and other assets
```

## Getting Started
1. **Install Flutter:**  
   [Flutter installation guide](https://docs.flutter.dev/get-started/install)
2. **Clone the repository:**
   ```sh
   git clone <your-repo-url>
   cd Foody
   ```
3. **Install dependencies:**
   ```sh
   flutter pub get
   ```
4. **Run the app:**
   ```sh
   flutter run
   ```

## Dependencies
- [get](https://pub.dev/packages/get)
- [hive](https://pub.dev/packages/hive)
- [shared_preferences](https://pub.dev/packages/shared_preferences)
- [dio](https://pub.dev/packages/dio)
- [http](https://pub.dev/packages/http)
- [google_fonts](https://pub.dev/packages/google_fonts)
- [flutter_svg](https://pub.dev/packages/flutter_svg)
- [cached_network_image](https://pub.dev/packages/cached_network_image)
- ...and more (see `pubspec.yaml` for the full list)

## How to Contribute
1. Fork the repo and create your branch.
2. Make your changes and test thoroughly.
3. Submit a pull request.

