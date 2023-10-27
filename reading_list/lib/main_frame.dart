import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_list/login_frame.dart';
import 'package:reading_list/page/create_row.dart';
import 'package:reading_list/page/reading_list.dart';

import 'controllers.dart';

class MainFrame extends StatelessWidget {
  MainFrame({super.key});

  final backEnd = Get.put(BackEndConnector());

  @override
  Widget build(BuildContext context) {
    return backEnd.isLogin
        ? Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      '読書リスト',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(6), // <-- Radius
                            ),
                            backgroundColor:
                                const Color.fromRGBO(22, 161, 184, 1)),
                        onPressed: () {
                          Get.to(CreateRowPage());
                        },
                        child: const Text(
                          '新規追加',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ReadingListPage(),
                  ),
                ],
              ),
            ),
          )
        : LoginFrame();
  }
}
