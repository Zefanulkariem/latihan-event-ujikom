import 'package:event_latihan/app/data/profile_response.dart';
import 'package:event_latihan/app/utils/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final box = GetStorage();
  final _getConnect = GetConnect();
  final token = GetStorage().read('token');
  final isLoading = false.obs;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  Future<ProfileResponse> getProfile() async {
    try {
      final response = await _getConnect.get(
        BaseUrl.profile,
        headers: {'Authorization': "Bearer $token"},
        contentType: "application/json",
      );

      if (response.statusCode == 200) {
        return ProfileResponse.fromJson(response.body);
      } else {
        throw Exception("Failed to load profile: ${response.statusText}");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  void logout() {
    box.remove('token');
    Get.offAllNamed('/login');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
