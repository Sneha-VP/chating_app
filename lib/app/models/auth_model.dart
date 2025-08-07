class AuthStatus {
  final String accessToken;
  final String tokenType;

  AuthStatus({
    required this.accessToken,
    required this.tokenType,
  });

  factory AuthStatus.fromJson(Map<String, dynamic> json) {
    return AuthStatus(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }
}

class OtpResponseModel {
  final String id;
  final String name;
  final String phone;
  final AuthStatus authStatus;

  OtpResponseModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.authStatus,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return OtpResponseModel(
      id: data['id'].toString(),
      name: data['name'] ?? "",
      phone: data['phone'] ?? "",
      authStatus: AuthStatus.fromJson(data['auth_status']),
    );
  }
}
