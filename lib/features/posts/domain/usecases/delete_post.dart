import 'package:dartz/dartz.dart';
import 'package:postsapp/core/errors/failurs.dart';
import 'package:postsapp/features/posts/domain/repositories/posts_repo.dart';

class DeletePostUsecase {
  final PostsRepo repo;

  DeletePostUsecase(this.repo);

  Future<Either<Failure, Unit>> call(int id) async {
    return await repo.deletePost(id);
  }
}
