import 'package:pocketbase/pocketbase.dart';
import 'package:proklinik_staff_portal/api/base/base.dart';

class HxAppUsers {
  const HxAppUsers();

  Future<RecordAuth> loginUserByEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await PocketbaseHelper.pb
          .collection("app_users")
          .authWithPassword(email, password);
      return result;
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }

  Future<void> requestPasswordReset(String email) async {
    try {
      await PocketbaseHelper.pb
          .collection("app_users")
          .requestPasswordReset(email);
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }
}
