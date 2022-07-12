
import 'dart:convert';

import 'package:book/models/book_list_response.dart';
import 'package:book/views/detail_book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
class BookController extends ChangeNotifier {
   BookListResponse? bookList;
  fetchBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response =
     await http.get(url,);
    print('response status: ${response.statusCode}');
    print('response body: ${response.body}');

    if(response.statusCode == 200) {
    final jsonBookList = jsonDecode(response.body);
    bookList = BookListResponse.fromJson(jsonBookList);
    notifyListeners();
    }
    
  }
}