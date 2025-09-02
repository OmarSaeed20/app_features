enum BuildEnvironment { dev, staging, production }

class Environment {
  static late BuildEnvironment _buildEnvironment;
  
  static BuildEnvironment get buildEnvironment => _buildEnvironment;
  
  static void init(BuildEnvironment env) {
    _buildEnvironment = env;
  }
  
  static String get apiUrl {
    switch (_buildEnvironment) {
      case BuildEnvironment.dev:
        return 'https://dev-api.example.com';
      case BuildEnvironment.staging:
        return 'https://staging-api.example.com';
      case BuildEnvironment.production:
        return 'https://api.example.com';
    }
  }
  
  static String get appName {
    switch (_buildEnvironment) {
      case BuildEnvironment.dev:
        return 'App Dev';
      case BuildEnvironment.staging:
        return 'App Staging';
      case BuildEnvironment.production:
        return 'App';
    }
  }
}