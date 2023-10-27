import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_list/component/login_menu.dart';
import 'package:reading_list/page/register_body.dart';

import 'controllers.dart';
import 'page/login_body.dart';

class LoginFrame extends StatelessWidget {
  LoginFrame({Key? key}) : super(key: key);

  final backEnd = Get.put(BackEndConnector());
  final uiState = Get.put(LoginFrameController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f5),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 8),
          children: [
            LoginMenu(),
            // MediaQuery.of(context).size.width >= 980
            //     ? Menu()
            //     : SizedBox(), // Responsive
            uiState.loginPageSwitcher == 0 ? LoginBody() : RegisterBody(),
          ],
        ),
      ),
    );
  }
}
