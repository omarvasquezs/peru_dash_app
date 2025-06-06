class ApiConfig {
  // DDEV Configuration
  static const String _baseUrlProduction = 'https://perudashapi.ddev.site/api';
  static const String _baseUrlLocal = 'http://192.168.1.31:32800/api'; // Your computer's IP
  static const String _baseUrlEmulator = 'http://10.0.2.2:32800/api';   // Android emulator
  
  // Current environment - change this based on your testing scenario
  static const bool _isProduction = false;
  static const bool _isEmulator = true; // Set to true if testing on emulator
  
  static String get baseUrl {
    if (_isProduction) {
      return _baseUrlProduction;
    } else if (_isEmulator) {
      return _baseUrlEmulator;
    } else {
      return _baseUrlLocal;
    }
  }
  
  // API Endpoints
  static String get registerDriver => '$baseUrl/register/driver';
  static String get registerCustomer => '$baseUrl/register/customer';
  static String get registerBusiness => '$baseUrl/register/business';
  static String get login => '$baseUrl/login';
  static String get logout => '$baseUrl/logout';
  static String get profile => '$baseUrl/profile';
  
  // Headers
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  static Map<String, String> getAuthHeaders(String token) => {
    ...headers,
    'Authorization': 'Bearer $token',
  };
}
