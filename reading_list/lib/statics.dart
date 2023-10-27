//error handle
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reading_list/constants.dart';

Map responseErrorHandle(Object e) => {
      "status": false,
      "content": e.toString().contains('Timeout')
          ? 'Server Not Response after 20s!'
          : e.toString().replaceAll('Exception:', ''),
    };

void callLoadIndicator() {
  Get.dialog(
      SizedBox(
        height: Get.height * 0.2,
        width: Get.width * 0.2,
        child: LoadingAnimationWidget.fourRotatingDots(
          color: primary,
          size: 50,
        ),
      ),
      barrierDismissible: false);
}

Map accountInfoInputValidation(
    {String userName = '',
    required String account,
    required String password,
    required String type}) {
  Map result = {
    'status': false,
    'content': null,
  };

  if (type == 'login') {
    if (account.isNotEmpty && password.isNotEmpty) {
      if (!account.contains('@')) {
        result['content'] = Exception("Account should be an E-mail.");
        return result;
      }
      if (password.length < 6 || account.length < 6) {
        result['content'] = Exception(
            "The password should be more than 8 characters in length.");
        return result;
      }
    } else {
      result['content'] = Exception("Input can't be empty!");
      return result;
    }
  }

  if (type == 'register') {
    if (userName.isNotEmpty && account.isNotEmpty && password.isNotEmpty) {
      if (!account.contains('@')) {
        result['content'] = Exception("Account should be an E-mail.");
        return result;
      }
      if (userName.length > 15) {
        result['content'] =
            Exception("The username should be under 16 characters in length.");
        return result;
      }
      if (password.length < 6 || account.length < 6) {
        result['content'] = Exception(
            "The password should be more than 8 characters in length.");
        return result;
      }
    } else {
      result['content'] = Exception("Input can't be empty!");
      return result;
    }
  }

  result['status'] = true;
  result['content'] = 'pass';
  return result;
}
