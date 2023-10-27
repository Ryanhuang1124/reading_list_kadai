import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_list/constants.dart';
import 'package:reading_list/controllers.dart';

class LoginMenu extends StatelessWidget {
  LoginMenu({super.key});

  final loginLayoutState = Get.put(LoginFrameController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 80),
                child: InkWell(
                    onTap: () {
                      loginLayoutState.loginPageSwitcher = 0;
                    },
                    child: _menuItem(title: 'Sign In', isActive: true)),
              ),
              InkWell(
                  onTap: () {
                    loginLayoutState.loginPageSwitcher = 1;
                  },
                  child: _registerButton())
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuItem({String title = 'Title Menu', isActive = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? primaryAncient : Colors.grey,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          isActive
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget _registerButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      decoration: BoxDecoration(
        color: primaryAncient,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: primaryAncient,
            spreadRadius: 2,
            blurRadius: 12,
          ),
        ],
      ),
      child: const Text(
        'Register',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
