import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_list/models.dart';
import 'package:reading_list/statics.dart';

class LoginBodyController extends GetxController {
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _errorMessage = ''.obs;

  set errorMessage(value) => _errorMessage.value = value;
  void resetErrorMessage() => _errorMessage.value = '';

  get errorMessage => _errorMessage.value;

  get accountController => _accountController;
  get passwordController => _passwordController;
}

class LoginFrameController extends GetxController {
  final _loginPageSwitcher = 0.obs;
  set loginPageSwitcher(value) => _loginPageSwitcher.value = value;
  get loginPageSwitcher => _loginPageSwitcher.value;
}

class ReadingListController extends GetxController {
  final backEnd = Get.put(BackEndConnector());
  List _tableRowDataList = <TableRowData>[].obs;
  late final _getSelfBook = Future.value().obs;
  final _rowSelected = 0.obs;

  set tableRowDataList(value) => _tableRowDataList = value;
  get tableRowDataList => _tableRowDataList;

  set rowSelected(value) => _rowSelected.value = value;
  get rowSelected => _rowSelected.value;

  set getSelfBook(value) => _getSelfBook.value = value;
  get getSelfBook => _getSelfBook.value;

  @override
  void onInit() {
    getSelfBook = backEnd.getSelfBook();
    super.onInit();
  }
}

class EditRowController extends GetxController {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _partController = TextEditingController();
  final _publishingController = TextEditingController();
  final _memoController = TextEditingController();

  get titleController => _titleController;
  get authorController => _authorController;
  get partController => _partController;
  get publishingController => _publishingController;
  get memoController => _memoController;

  void clearAllInput() {
    titleController.clear();
    authorController.clear();
    partController.clear();
    publishingController.clear();
    memoController.clear();
  }
}

class CreatRowController extends GetxController {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _partController = TextEditingController();
  final _publishingController = TextEditingController();
  final _memoController = TextEditingController();

  get titleController => _titleController;
  get authorController => _authorController;
  get partController => _partController;
  get publishingController => _publishingController;
  get memoController => _memoController;

  void clearAllInput() {
    titleController.clear();
    authorController.clear();
    partController.clear();
    publishingController.clear();
    memoController.clear();
  }
}

class BackEndConnector extends GetConnect {
  String uri = "https://reading-list-fast.onrender.com/";
  String _accessToken = "initiate";
  bool _isLogin = false;

  get accessToken => _accessToken;
  get isLogin => _isLogin;

  Future<Map> register(
      {required String userName,
      required String account,
      required String password}) async {
    String route = '${uri}user/register';
    Map result = {};

    var body = {"name": userName, "account": account, "password": password};
    try {
      var response =
          await post(route, body).timeout(const Duration(seconds: 20));

      if (response.statusCode != 201) {
        throw Exception(response.body['detail']);
      }
      result['status'] = true;
      result['content'] = response.body;
    } catch (e) {
      result = responseErrorHandle(e);
    }
    return result;
  }

  Future<Map> login({required String account, required String passwd}) async {
    String route = '${uri}auth/login';
    Map result = {};

    var contentType = "application/x-www-form-urlencoded";
    var body = {"username": account, "password": passwd};

    try {
      var response = await post(route, body, contentType: contentType)
          .timeout(const Duration(seconds: 20));

      if (response.statusCode != 200) {
        throw Exception(response.body['detail']);
      }
      result['status'] = true;
      result['content'] = response.body;

      _accessToken = response.body['access_token'];
      _isLogin = true;
    } catch (e) {
      result = responseErrorHandle(e);
    }
    return result;
  }

  Future<Map> getSelfBook() async {
    String route = '${uri}book/';
    Map result = {};

    var header = {"Authorization": "bearer $accessToken"};

    var response =
        await get(route, headers: header).timeout(const Duration(seconds: 20));
    result['status'] = true;
    result['content'] = response.body;

    return result;
  }

  Future<Map> createBook({
    required String title,
    required String part,
    required String author,
    required String publishing,
    required String memo,
  }) async {
    String route = '${uri}book/create';
    Map result = {};
    var header = {"Authorization": "bearer $accessToken"};
    var body = {
      "title": title,
      "part": part,
      "author": author,
      "publishing": publishing,
      "memo": memo,
    };

    var response = await post(route, body, headers: header)
        .timeout(const Duration(seconds: 20));

    result['status'] = true;
    result['content'] = response.body;

    return result;
  }

  Future<Map> editBookByBookId(
      {required String bookId,
      required String newTitle,
      required String newPart,
      required String newAuthor,
      required String newPublishing,
      required String newMemo}) async {
    String route = '${uri}book/edit_book?book_id=$bookId';
    Map result = {};
    var header = {"Authorization": "bearer $accessToken"};
    var body = {
      "title": newTitle,
      "part": newPart,
      "author": newAuthor,
      "publishing": newPublishing,
      "memo": newMemo
    };
    var contentType = "application/json";

    try {
      var response =
          await put(route, body, headers: header, contentType: contentType);

      result['status'] = true;
      result['content'] = response.body;
    } catch (e) {
      result = responseErrorHandle(e);
    }
    return result;
  }

  Future<Map> deleteBookByBookId({required String bookId}) async {
    String route = '${uri}book/delete?book_id=$bookId';
    Map result = {};
    var header = {"Authorization": "bearer $accessToken"};

    try {
      var response = await delete(route, headers: header)
          .timeout(const Duration(seconds: 20));

      result['status'] = true;
      result['content'] = response.body;
    } catch (e) {
      result = responseErrorHandle(e);
    }
    return result;
  }
}

class RegisterController extends GetxController {
  final _userNameController = TextEditingController();
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _errorMessage = ''.obs;

  set errorMessage(value) => _errorMessage.value = value;
  void resetErrorMessage() => _errorMessage.value = '';

  get errorMessage => _errorMessage.value;

  get userNameController => _userNameController;

  get accountController => _accountController;

  get passwordController => _passwordController;
}
