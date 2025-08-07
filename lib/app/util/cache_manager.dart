import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  final box = GetStorage();

  Future<bool> saveToken(String? token) async {
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  Future<bool> saveUserId(String? userId) async {
    await box.write(CacheManagerKey.USERID.toString(), userId);
    return true;
  }

  String? get token => box.read(CacheManagerKey.TOKEN.toString()) ?? "";
  String? get userId => box.read(CacheManagerKey.USERID.toString()) ?? "";
}

enum CacheManagerKey {
  TOKEN,
  USERID,
}
