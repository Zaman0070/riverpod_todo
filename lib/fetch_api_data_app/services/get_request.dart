import 'dart:convert';

import 'package:flutter_riverpod_todo_app/fetch_api_data_app/models/posts.dart';
import 'package:http/http.dart' as http;

class HttpGetRequest {
  static const String BASE_URL = "https://jsonplaceholder.typicode.com";
  static const String POSTS = "/posts";

  Future<List<Post>> getPosts() async {
    List<Post> posts = [];
    try {
      Uri postUri = Uri.parse(BASE_URL + POSTS);
      http.Response response = await http.get(postUri);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        posts = body.map((dynamic item) => Post.fromMap(item)).toList();
      }
    } catch (e) {
      print(e);
    }
    return posts;
  }
}
