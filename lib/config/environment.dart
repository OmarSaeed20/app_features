enum BuildEnvironment { dev, staging, production }

class Environment {
  static late BuildEnvironment _buildEnvironment;
  static late Map<String, dynamic> _config;

  static BuildEnvironment get buildEnvironment => _buildEnvironment;

  static void init(BuildEnvironment env) {
    _buildEnvironment = env;
    _loadConfig();
  }

  static void _loadConfig() {
    // In a real app, you might load this from a JSON file or API
    // For now, we'll use hardcoded values that match your JSON configs
    switch (_buildEnvironment) {
      case BuildEnvironment.dev:
        _config = {
          'ENV': 'development',
          'APP_NAME': 'DropMe Dev',
          'API_BASE_URL': 'https://dev-api.dropme.com',
          'FIREBASE_APP_ID': '1:663414934306:android:638a04260231b8d8a1337b',
        };
        break;
      case BuildEnvironment.staging:
        _config = {
          'ENV': 'staging',
          'APP_NAME': 'DropMe Staging',
          'API_BASE_URL': 'https://staging-api.dropme.com',
          'FIREBASE_APP_ID': '1:663414934306:android:bd19ad7180c8b884a1337b',
        };
        break;
      case BuildEnvironment.production:
        _config = {
          'ENV': 'production',
          'APP_NAME': 'DropMe',
          'API_BASE_URL': 'https://api.dropme.com',
          'FIREBASE_APP_ID': '1:663414934306:android:0f3c143d45a83e80a1337b',
        };
        break;
    }
  }

  static String get env => _config['ENV'] ?? 'development';
  static String get appName => _config['APP_NAME'] ?? 'DropMe';
  static String get apiBaseUrl => _config['API_BASE_URL'] ?? '';
  static String get firebaseAppId => _config['FIREBASE_APP_ID'] ?? '';
  
  static bool get isProduction => _buildEnvironment == BuildEnvironment.production;
  static bool get isStaging => _buildEnvironment == BuildEnvironment.staging;
  static bool get isDevelopment => _buildEnvironment == BuildEnvironment.dev;
  static bool get debug => !isProduction;
  
  // Convenience getter for API URL
  static String get apiUrl => apiBaseUrl;
}