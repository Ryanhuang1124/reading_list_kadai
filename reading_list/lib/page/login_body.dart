import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_list/constants.dart';
import 'package:reading_list/controllers.dart';
import 'package:reading_list/main_frame.dart';
import 'package:reading_list/statics.dart';

class LoginBody extends StatelessWidget {
  LoginBody({super.key});

  final loginLayoutState = Get.put(LoginFrameController());
  final uiState = Get.put(LoginBodyController());
  final backEnd = Get.put(BackEndConnector());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: Get.width * 0.35,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sign In to \nReading List',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "If you don't have an account",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "You can",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      loginLayoutState.loginPageSwitcher = 1;
                    },
                    child: const Text(
                      "Register here!",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 6),
          child: SizedBox(
            width: Get.width * 0.35,
            child: _formLogin(),
          ),
        )
      ],
    );
  }

  Widget _formLogin() {
    return Column(
      children: [
        TextField(
          controller: uiState.accountController,
          decoration: InputDecoration(
            hintText: 'Enter email ',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        const SizedBox(height: 30),
        TextField(
          controller: uiState.passwordController,
          decoration: InputDecoration(
            hintText: 'Password',
            counterText: 'Forgot password?',
            suffixIcon: const Icon(
              Icons.visibility_off_outlined,
              color: Colors.grey,
            ),
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                spreadRadius: 4,
                blurRadius: 16,
                color: primaryAncient,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () async {
              uiState.resetErrorMessage();
              String account = uiState.accountController.text;
              String password = uiState.passwordController.text;

              callLoadIndicator();
              Map validation = accountInfoInputValidation(
                  account: account, password: password, type: 'login');

              try {
                if (!validation['status']) {
                  throw validation['content'];
                }
                await backEnd
                    .login(account: account, passwd: password)
                    .then((value) {
                  if (!value['status']) {
                    throw Exception(value['content']);
                  }
                }).whenComplete(() => Get.back(closeOverlays: true));

                Get.to(() => MainFrame());
              } catch (e) {
                Get.back(closeOverlays: true);
                uiState.errorMessage = e.toString();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryAncient,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(child: Text("Sign In"))),
          ),
        ),
        const SizedBox(height: 40),
        Obx(() => Visibility(
            visible: uiState.errorMessage.isNotEmpty,
            child: Text(
              uiState.errorMessage,
              style: const TextStyle(color: Colors.red),
            ))),
        const SizedBox(height: 40),
        Row(children: [
          Expanded(
            child: Divider(
              color: Colors.grey[300],
              height: 50,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("Or continue with"),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey[400],
              height: 50,
            ),
          ),
        ]),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _loginWithButton(image: 'assets/imgs/google.png'),
            _loginWithButton(image: 'assets/imgs/github.png'),
            _loginWithButton(image: 'assets/imgs/facebook.png'),
          ],
        ),
      ],
    );
  }

  Widget _loginWithButton({required String image, bool isActive = false}) {
    return Container(
      width: 90,
      height: 70,
      decoration: isActive
          ? BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 10,
                  blurRadius: 30,
                )
              ],
              borderRadius: BorderRadius.circular(15),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey),
            ),
      child: Center(
          child: Container(
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 15,
                  )
                ],
              )
            : const BoxDecoration(),
        child: Image.asset(
          image,
          width: 35,
        ),
      )),
    );
  }
}
