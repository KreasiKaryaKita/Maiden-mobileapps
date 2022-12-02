// ignore_for_file: unnecessary_overrides

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maiden_employer/app/routes/app_pages.dart';
import 'package:maiden_employer/app/shared/common/common_function.dart';

class ValidateEmailForgotPasswordController extends GetxController {
  TextEditingController inputOTP = TextEditingController();
  late Timer timer;
  RxInt start = 0.obs;

  @override
  void onInit() {
    super.onInit();
    start.value = 30;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
        } else {
          start--;
        }
        printInfo(info: start.value.toString());
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    timer.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void startTimer() async {
    if (start.value == 0) {
      start.value = 30;
      const oneSec = Duration(seconds: 1);
      timer = Timer.periodic(
        oneSec,
        (Timer timer) {
          if (start.value == 0) {
            timer.cancel();
          } else {
            start--;
          }
          printInfo(info: start.value.toString());
        },
      );
    }
  }

  onCompleted(value) {
    CommonFunction.loadingShow(message: "msg_loading_2");
    Future.delayed(
      Duration(seconds: 5),
      () {
        CommonFunction.loadingHide();
        Get.offNamed(Routes.CREATE_PASSWORD);
      },
    );
  }
}
