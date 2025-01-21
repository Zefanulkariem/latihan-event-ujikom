import 'package:event_latihan/app/modules/dashboard/views/dashboard_view.dart';
import 'package:event_latihan/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController
  final _getConnect = GetConnect();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  final authToken = GetStorage();

  void registerNow() async {
    final response = await _getConnect.post(BaseUrl.register, {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'password_confirmation': passwordConfirmController.text,
    });

    if (response.statusCode == 201) {
      authToken.write('token', response.body['token']);
      Get.offAll(() => const DashboardView());
    } else {
      Get.snackbar(
        'Error',
        response.body['error'].toString(),
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        forwardAnimationCurve: Curves.bounceIn,
        margin: const EdgeInsets.only(
          top: 10,
          left: 5,
          right: 5,
        ),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    passwordConfirmController.dispose();
    super.onClose();
  }
}
