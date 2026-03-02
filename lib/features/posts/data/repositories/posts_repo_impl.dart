import 'package:dartz/dartz.dart';
import 'package:postsapp/core/errors/exceptions.dart';
import 'package:postsapp/core/errors/failurs.dart';
import 'package:postsapp/core/network/network_info.dart';
import 'package:postsapp/features/posts/data/datasourses/post_local_data_source.dart';
import 'package:postsapp/features/posts/data/datasourses/post_remote_data_source.dart';
import 'package:postsapp/features/posts/data/models/post_model.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/domain/repositories/posts_repo.dart';

typedef Future<Unit> DeletOrUpdateOrAddPost();

class PostsRepoImpl implements PostsRepo {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on serverException {
        return Left(ServerFailure('message'));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        final localPosts = await localDataSource.getCashedPosts();
        return Right(localPosts);
      } on CacheFailure {
        return left(CacheFailure('message'));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(title: post.title, body: post.body);
    return await _deletOrUpdateOrAdd(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _deletOrUpdateOrAdd(() {
      return remoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _deletOrUpdateOrAdd(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _deletOrUpdateOrAdd(
    DeletOrUpdateOrAddPost deletOrUpdateOrAddPost,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await deletOrUpdateOrAddPost();
        return Right(unit);
      } on serverException {
        return Left(ServerFailure('e'));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure('s'));
    }
  }
}
