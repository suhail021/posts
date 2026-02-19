import 'package:dartz/dartz.dart';
import 'package:postsapp/core/errors/failurs.dart';
import 'package:postsapp/features/posts/domain/repositories/posts_repo.dart';

class GetAllPostsUsecase {
  final PostsRepo repo;
  
  GetAllPostsUsecase(this.repo);

  Future<Either<Failure, List>> call() async {
    return await repo.getAllPosts();
  } 
}