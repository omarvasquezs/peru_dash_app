import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peru_dash_app/config/api_config.dart';

class ApiService {
  // Driver Registration
  static Future<Map<String, dynamic>> registerDriver({
    required String fullName,
    required String dni,
    required String dateOfBirth,
    required String phone,
    required String email,
    required String password,
    required String address,
    required String distrito,
    required String provincia,
    required String departamento,
    required String vehicleType,
    String? licensePlate,
    required bool hasHelmet,
    required bool hasThermalBag,
    required String workSchedule,
    String? workZones,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.registerDriver),
        headers: ApiConfig.headers,
        body: jsonEncode({
          'full_name': fullName,
          'dni': dni,
          'date_of_birth': dateOfBirth,
          'phone_number': phone,
          'email': email,
          'password': password,
          'address': address,
          'distrito': distrito,
          'provincia': provincia,
          'departamento': departamento,
          'vehicle_type': vehicleType,
          'license_plate': licensePlate,
          'has_helmet': hasHelmet,
          'has_thermal_bag': hasThermalBag,
          'work_schedule': workSchedule,
          'work_zones': workZones,
          'user_type': 'driver',
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: ${e.toString()}',
      };
    }
  }

  // Customer Registration
  static Future<Map<String, dynamic>> registerCustomer({
    required String fullName,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.registerCustomer),
        headers: ApiConfig.headers,
        body: jsonEncode({
          'full_name': fullName,
          'email': email,
          'password': password,
          'phone_number': phone,
          'user_type': 'customer',
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: ${e.toString()}',
      };
    }
  }

  // Login
  static Future<Map<String, dynamic>> login({
    required String identifier, // email or phone
    required String password,
    required String userType,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.login),
        headers: ApiConfig.headers,
        body: jsonEncode({
          'identifier': identifier,
          'password': password,
          'user_type': userType,
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: ${e.toString()}',
      };
    }
  }

  // Business Registration
  static Future<Map<String, dynamic>> registerBusiness({
    required String businessName,
    required String ruc,
    required String businessType,
    required String legalRepresentativeName,
    required String legalRepresentativeDni,
    required String addressStreet,
    required String addressDistrict,
    required String addressProvince,
    required String addressDepartment,
    required String phoneNumber,
    required String corporateEmail,
    required String password,
    required Map<String, dynamic> operatingHours,
    required bool agreedToTerms,
    required bool agreedToPrivacy,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://perudashapi.ddev.site/api/register/business'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'business_name': businessName,
          'ruc': ruc,
          'business_type': businessType,
          'legal_representative_name': legalRepresentativeName,
          'legal_representative_dni': legalRepresentativeDni,
          'address_street': addressStreet,
          'address_district': addressDistrict,
          'address_province': addressProvince,
          'address_department': addressDepartment,
          'phone_number': phoneNumber,
          'corporate_email': corporateEmail,
          'password': password,
          'operating_hours': operatingHours,
          'user_type': 'business',
          'agreed_to_terms': agreedToTerms,
          'agreed_to_privacy': agreedToPrivacy,
        }),
      );
      return _handleResponse(response);
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: ${e.toString()}',
      };
    }
  }

  // Handle HTTP Response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    try {
      final data = jsonDecode(response.body);
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'success': true,
          'data': data,
          'message': data['message'] ?? 'Operación exitosa',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Error del servidor',
          'errors': data['errors'] ?? {},
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error procesando respuesta del servidor',
      };
    }
  }
}
