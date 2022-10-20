// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maiden_employer/app/routes/app_pages.dart';
import 'package:maiden_employer/app/shared/utils/my_helper.dart';

class ForgotPasswordController extends GetxController {
  RxBool isValidateFirst = false.obs;

  TextEditingController inputEmail = TextEditingController();
  RxBool validateEmail = true.obs;
  RxString msgEmail = "".obs;

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
    super.onClose();
  }

  onValidationFormInput(String? val) {
    if (isValidateFirst.value) {
      String valueEmail = inputEmail.text.toString().trim();

      if (valueEmail.isEmpty) {
        validateEmail.value = false;
        msgEmail.value = "email_validation_2".tr;
      } else {
        if (!MyHelpers.validateEmail(valueEmail)) {
          validateEmail.value = false;
          msgEmail.value = "email_validation".tr;
        } else {
          validateEmail.value = true;
          msgEmail.value = "";
        }
      }
    }

    return validateEmail.value;
  }

  Future doForgotPassword() async {
    isValidateFirst.value = true;
    bool validation = onValidationFormInput(null);
    if (validation) {
      Get.offNamed(Routes.CREATE_PASSWORD);
    }
  }
}
