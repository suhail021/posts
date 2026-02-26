import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:postsapp/core/network/network_info.dart';
import 'package:postsapp/features/posts/data/datasourses/post_local_data_source.dart';
import 'package:postsapp/features/posts/data/datasourses/post_remote_data_source.dart';
import 'package:postsapp/features/posts/data/repositories/posts_repo_impl.dart';
import 'package:postsapp/features/posts/domain/repositories/posts_repo.dart';
import 'package:postsapp/features/posts/domain/usecases/add_post.dart';
import 'package:postsapp/features/posts/domain/usecases/delete_post.dart';
import 'package:postsapp/features/posts/domain/usecases/get_all_posts.dart';
import 'package:postsapp/features/posts/domain/usecases/update_post.dart';
import 'package:postsapp/features/posts/presentation/bloc/add_delete_update_posts_bloc/add_delete_update_posts_bloc.dart';
import 'package:postsapp/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// features -- Posts

  // Bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(
    () => AddDeleteUpdatePostsBloc(
      addPost: sl(),
      updatePost: sl(),
      deletePost: sl(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(() => GetAllPostsUsecase(sl()));
  sl.registerLazySingleton(() => AddPostUsecase(sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(sl()));
  // Repo
  sl.registerLazySingleton<PostsRepo>(
    () => PostsRepoImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Datasources
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<PostLocalDataSource>(
    () => PostsLocalDataSourceImpl(sharedPreferences: sl()),
  );

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.instance,
  );
}
