import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_list/main_frame.dart';
import 'package:reading_list/models.dart';

import '../controllers.dart';
import '../statics.dart';

class EditRowPage extends StatelessWidget {
  EditRowPage({super.key, required this.bookId});
  final String bookId;

  final uiState = Get.put(EditRowController());
  final backEnd = Get.put(BackEndConnector());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '書籍情報の編集',
            style: TextStyle(fontSize: 20),
          ),
          const Text(
            '書籍情報を編集します',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: Get.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '書名',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextFormField(
                    controller: uiState.titleController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black87,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black87,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: Get.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '卷数',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextFormField(
                    controller: uiState.partController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black87,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black87,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: Get.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '著者',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextFormField(
                    controller: uiState.authorController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black87,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black87,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: Get.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '出版社',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextFormField(
                    controller: uiState.publishingController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black87,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black87,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: Get.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'メモ',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextFormField(
                    controller: uiState.memoController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black87,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black87,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6), // <-- Radius
                        ),
                        backgroundColor:
                            const Color.fromRGBO(108, 117, 125, 1)),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      '戻る',
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6), // <-- Radius
                        ),
                        backgroundColor: const Color.fromRGBO(2, 123, 255, 1)),
                    onPressed: () {
                      String title = uiState.titleController.text;
                      String part = uiState.partController.text;
                      String author = uiState.authorController.text;
                      String publishing = uiState.publishingController.text;
                      String memo = uiState.memoController.text;

                      if (title.isNotEmpty &&
                          part.isNotEmpty &&
                          author.isNotEmpty &&
                          publishing.isNotEmpty &&
                          memo.isNotEmpty) {
                        TableRowData newRow = TableRowData(
                            bookId: bookId,
                            title: title,
                            part: part,
                            author: author,
                            publishing: publishing,
                            memo: memo);
                        Get.defaultDialog(
                            title: '登録情報の確認',
                            middleText: '登録内容を確認して下さい',
                            onConfirm: () async {
                              callLoadIndicator();
                              await backEnd
                                  .editBookByBookId(
                                      bookId: bookId,
                                      newTitle: title,
                                      newAuthor: author,
                                      newMemo: memo,
                                      newPart: part,
                                      newPublishing: publishing)
                                  .whenComplete(() {
                                Get.offAll(MainFrame());
                              });
                              uiState.clearAllInput();
                            },
                            onCancel: () {},
                            content: SizedBox(
                              width: Get.width * 0.4,
                              child: Column(
                                children: [
                                  Table(
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                            child: Container(
                                                color: const Color.fromRGBO(
                                                    33, 37, 41, 1),
                                                child: const Center(
                                                  child: Text(
                                                    '書名',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                ))),
                                        TableCell(
                                            child: Container(
                                                color: const Color.fromRGBO(
                                                    33, 37, 41, 1),
                                                child: const Center(
                                                  child: Text(
                                                    '卷数',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                ))),
                                        TableCell(
                                            child: Container(
                                                color: const Color.fromRGBO(
                                                    33, 37, 41, 1),
                                                child: const Center(
                                                  child: Text(
                                                    '著者',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                ))),
                                        TableCell(
                                            child: Container(
                                                color: const Color.fromRGBO(
                                                    33, 37, 41, 1),
                                                child: const Center(
                                                  child: Text(
                                                    '出版社',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                ))),
                                        TableCell(
                                            child: Container(
                                                color: const Color.fromRGBO(
                                                    33, 37, 41, 1),
                                                child: const Center(
                                                  child: Text(
                                                    'メモ',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                ))),
                                      ]),
                                      TableRow(children: [
                                        Center(
                                            child: Text(
                                          newRow.title,
                                          style: const TextStyle(fontSize: 16),
                                        )),
                                        Center(
                                            child: Text(
                                          newRow.part,
                                          style: const TextStyle(fontSize: 16),
                                        )),
                                        Center(
                                            child: Text(
                                          newRow.author,
                                          style: const TextStyle(fontSize: 16),
                                        )),
                                        Center(
                                            child: Text(
                                          newRow.publishing,
                                          style: const TextStyle(fontSize: 16),
                                        )),
                                        Center(
                                            child: Text(
                                          newRow.memo,
                                          style: const TextStyle(fontSize: 16),
                                        )),
                                      ])
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      } else {
                        Get.snackbar('エラー', '全ての欄が入力されていることを確認してください');
                      }
                    },
                    child: const Text(
                      '完成',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
