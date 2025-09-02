# Clean build
flutter clean
cd android && ./gradlew clean && cd ..

# Run Dev
flutter run --flavor dev -t lib/main_dev.dart

# Run Staging
flutter run --flavor staging -t lib/main_staging.dart

# Run Production
flutter run --flavor prod -t lib/main.dart

# Build APK Dev
flutter build apk --flavor dev -t lib/main_dev.dart

# Build APK Staging
flutter build apk --flavor staging -t lib/main_staging.dart

# Build APK Production (Release)
flutter build apk --release --flavor prod -t lib/main.dart

# Build App Bundle Production (for Play Store)
flutter build appbundle --release --flavor prod -t lib/main.dart