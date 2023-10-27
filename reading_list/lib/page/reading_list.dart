import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reading_list/constants.dart';
import 'package:reading_list/controllers.dart';
import 'package:reading_list/models.dart';
import 'package:reading_list/page/edit_row.dart';
import 'package:reading_list/statics.dart';

class ReadingListPage extends StatelessWidget {
  ReadingListPage({super.key});

  final uiState = Get.put(ReadingListController());
  final backEnd = Get.put(BackEndConnector());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FutureBuilder<Map>(
        future: uiState.getSelfBook,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            List<TableRowData> fetchedList = [];

            List bookList = snapshot.data!['content']['book_list'] as List;

            for (var book in bookList) {
              TableRowData row = TableRowData(
                  bookId: book['book_id'].toString(),
                  title: book['title'],
                  memo: book['memo'],
                  publishing: book['publishing'],
                  author: book['author'],
                  part: book['part']);
              fetchedList.add(row);
            }

            return Table(
              border: TableBorder.all(
                  color: Colors.black87, width: 1.0, style: BorderStyle.solid),
              children: tableRowBuilder(
                  tableRowDataList: fetchedList,
                  uiState: uiState,
                  backEnd: backEnd),
            );
          } else {
            return SizedBox(
              height: Get.height * 0.2,
              width: Get.width * 0.2,
              child: LoadingAnimationWidget.fourRotatingDots(
                color: primary,
                size: 50,
              ),
            );
          }
        },
      ),
    );
  }
}

List<TableRow> tableRowBuilder(
    {required tableRowDataList,
    required ReadingListController uiState,
    required BackEndConnector backEnd}) {
  List<TableRow> tableRowList = [];

  tableRowList.add(
    TableRow(children: [
      TableCell(
          child: Container(
              color: const Color.fromRGBO(33, 37, 41, 1),
              child: const Center(
                child: Text(
                  '書名',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ))),
      TableCell(
          child: Container(
              color: const Color.fromRGBO(33, 37, 41, 1),
              child: const Center(
                child: Text(
                  '卷数',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ))),
      TableCell(
          child: Container(
              color: const Color.fromRGBO(33, 37, 41, 1),
              child: const Center(
                child: Text(
                  '著者',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ))),
      TableCell(
          child: Container(
              color: const Color.fromRGBO(33, 37, 41, 1),
              child: const Center(
                child: Text(
                  '出版社',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ))),
      TableCell(
          child: Container(
              color: const Color.fromRGBO(33, 37, 41, 1),
              child: const Center(
                child: Text(
                  'メモ',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ))),
      TableCell(
          child: Container(
              color: const Color.fromRGBO(33, 37, 41, 1),
              child: const Center(
                child: Text(
                  '操作',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ))),
    ]),
  );

  for (var tableRowData in tableRowDataList) {
    tableRowList.add(TableRow(children: [
      Center(
          child: Text(
        tableRowData.title,
        style: const TextStyle(fontSize: 16),
      )),
      Center(
          child: Text(
        tableRowData.part,
        style: const TextStyle(fontSize: 16),
      )),
      Center(
          child: Text(
        tableRowData.author,
        style: const TextStyle(fontSize: 16),
      )),
      Center(
          child: Text(
        tableRowData.publishing,
        style: const TextStyle(fontSize: 16),
      )),
      Center(
          child: Text(
        tableRowData.memo,
        style: const TextStyle(fontSize: 16),
      )),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Get.to(EditRowPage(bookId: tableRowData.bookId));
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              callLoadIndicator();
              await backEnd
                  .deleteBookByBookId(bookId: tableRowData.bookId)
                  .whenComplete(() {
                Get.back();
              });
              uiState.getSelfBook = backEnd.getSelfBook();
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
    ]));
  }

  return tableRowList;
}
