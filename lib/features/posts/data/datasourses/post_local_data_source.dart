import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:postsapp/core/errors/failurs.dart';
import 'package:postsapp/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCashedPosts();
  Future<Unit> cachePosts(List<PostModel> postModels);
}

const CashedPosts = "CASHED_POSTS";

class PostsLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostsLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModels) => postModels.toJson())
        .toList();
    sharedPreferences.setString(CashedPosts, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCashedPosts() {
    final jsonString = sharedPreferences.getString(CashedPosts);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw CacheFailure('s');
    }
  }
}
