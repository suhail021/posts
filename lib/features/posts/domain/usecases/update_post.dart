import 'package:dartz/dartz.dart';
import 'package:postsapp/core/errors/failurs.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/domain/repositories/posts_repo.dart';

class UpdatePostUsecase {
  final PostsRepo repo;

  UpdatePostUsecase(this.repo);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repo.updatePost(post);
  }
}

