import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_list/constants.dart';
import 'package:reading_list/controllers.dart';
import 'package:reading_list/main_frame.dart';
import 'package:reading_list/statics.dart';

class RegisterBody extends StatelessWidget {
  RegisterBody({super.key});

  final uiState = Get.put(RegisterController());
  final backEnd = Get.put(BackEndConnector());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
          width: 360,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register for \nG - Chat Box',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 6),
          child: SizedBox(
            width: 320,
            child: _formRegister(),
          ),
        )
      ],
    );
  }

  Widget _formRegister() {
    return Column(
      children: [
        TextField(
          controller: uiState.userNameController,
          decoration: InputDecoration(
            hintText: "User's name",
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
        TextField(
          controller: uiState.accountController,
          decoration: InputDecoration(
            hintText: 'Enter email',
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
              String userName = uiState.userNameController.text;
              String account = uiState.accountController.text;
              String password = uiState.passwordController.text;

              callLoadIndicator();
              Map validation = accountInfoInputValidation(
                  userName: userName,
                  account: account,
                  password: password,
                  type: 'register');

              try {
                if (!validation['status']) {
                  throw validation['content'];
                }
                await backEnd
                    .register(
                        userName: userName,
                        account: account,
                        password: password)
                    .then((value) async {
                  if (!value['status']) {
                    throw Exception(value['content']);
                  } else {
                    await backEnd
                        .login(account: account, passwd: password)
                        .then((value) {
                      if (!value['status']) {
                        throw Exception(value['content']);
                      }
                    });
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
                child: Center(child: Text("Create Account"))),
          ),
        ),
        const SizedBox(height: 40),
        Obx(() => Visibility(
            visible: uiState.errorMessage.isNotEmpty,
            child: Text(
              uiState.errorMessage,
              style: const TextStyle(color: Colors.red),
            )))
      ],
    );
  }
}
