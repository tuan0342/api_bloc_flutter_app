import 'package:api_bloc_flutter/features/posts/models/posts_data_ui_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class PostsRepo {
  static Future<List<PostsDataUiModel>> fetchPosts() async {
    var client = http.Client();
    List<PostsDataUiModel> posts = [];
    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      final responseBody = jsonDecode(response.body);

      for (int i = 0; i < responseBody.length; i++) {
        PostsDataUiModel post = PostsDataUiModel.fromJson(responseBody[i]);
        posts.add(post);
      }

      return posts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<bool> addPost() async {
    var client = http.Client();
    try {
      var response = await client.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: {
          "title": "Tuan Ngo",
          "body": "Learning Bloc Flutter in Youtube",
          "userId": "24"
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
