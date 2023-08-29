import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_todo_app/fetch_api_data_app/services/get_request.dart';

import '../models/posts.dart';

final postNotifierProvider =
    StateNotifierProvider<PostNotifier, PostState>((ref) {
  return PostNotifier()..fetchData();
});

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<dynamic>  posts;
  PostLoaded({required this.posts});
}

class PostError extends PostState {
  final String message;
  PostError({required this.message});
}

class PostNotifier extends StateNotifier<PostState> {
  PostNotifier() : super(PostInitial());
  final HttpGetRequest httpGetRequest = HttpGetRequest();
  List<Post> posts = [];
  Future<void> fetchData() async {
    try {
      state = PostLoading();
      posts = await httpGetRequest.getPosts();
      state = PostLoaded(posts: posts);
    } catch (e) {
      state = PostError(message: e.toString());
    }
  }
}
