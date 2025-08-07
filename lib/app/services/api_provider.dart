import 'package:dating_app/app/util/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:japx/japx.dart';
import '../models/chat_model.dart';
import '../models/messages_model.dart';

class ApiProvider with CacheManager {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://test.myfliqapp.com/api/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
      },
      validateStatus: (status) => status != null && status < 500,
    ),
  );

  String? _token;

  /// Set Bearer Token after successful OTP verification
  void setToken(String token) {
    _token = token;
  }

  /// 🔹 Send OTP
  Future<Response> sendOtp(String phone) async {
    print("phone--send$phone");
    final data = {
      "data": {
        "type": "registration_otp_codes",
        "attributes": {
          "phone": phone,
        }
      }
    };

    return await _dio.post(
      '/auth/registration-otp-codes/actions/phone/send-otp',
      data: data,
    );
  }

  /// Verify OTP
  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    print("phone--$phone");
    print("otp--$otp");

    final body = {
      "data": {
        "type": "registration_otp_codes",
        "attributes": {
          "phone": phone.startsWith("+") ? phone : "+$phone",
          "otp": int.parse(otp),
          "device_meta": {
            "type": "web",
            "device-name": "HP Pavilion 14",
            "device-os-version": "Windows 10",
            "browser": "Chrome",
            "browser_version": "116",
            "user-agent": "Custom Flutter App",
            "screen_resolution": "1080x1920",
            "language": "en-IN"
          }
        }
      }
    };

    final response = await _dio.post(
      "/auth/registration-otp-codes/actions/phone/verify-otp",
      data: body,
    );

    // This will give `attributes` from JSON:API spec
    final parsed = Japx.decode(response.data);

    print("Parsed Response: $parsed");

    return parsed;
    // catch (e, stackTrace) {
    //   print("Error verifying OTP: $e");
    //   print(stackTrace);
    //   rethrow;
    // }
  }

  /// Get Chat Profile List
  Future<List<ChatProfileModel>> getChatProfiles() async {
    if (_token == null) {
      throw Exception('Access token is not set');
    }

    final response = await _dio.get(
      '/chat/chat-messages/queries/contact-users',
      options: Options(
        headers: {
          'Accept': 'application/vnd.api+json',
          'Authorization': 'Bearer $_token',
        },
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = Japx.decode(response.data);
      final List<dynamic> data = decoded['data'] ?? [];

      return data.map((item) => ChatProfileModel.fromJson(item)).toList();
    } else {
      throw Exception(
          'Failed to fetch chat profiles. Status: ${response.statusCode}');
    }
  }

  /// Get chat messages
  Future<List<ChatMessage>> fetchChatMessages(int user1, int user2) async {
    print("user1--" + user1.toString());
    print("user1--" + user2.toString());
    print("user1--" + token.toString());
    if (token == null) {
      throw Exception('Access token is not set');
    }
    final response = await _dio.get(
      '/chat/chat-messages/queries/chat-between-users/$user1/$user2',
      options: Options(
        headers: {
          'Accept': 'application/vnd.api+json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> parsed = Japx.decode(response.data);
      final List<dynamic> data = parsed['data'] ?? [];
      print("chat data===" + data.toString());
      return data.map((json) => ChatMessage.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to fetch chat messages. Status: ${response.statusCode}');
    }
  }
}
