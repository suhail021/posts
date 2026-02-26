import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:postsapp/core/errors/failurs.dart';
import 'package:postsapp/core/strings/failures.dart';
import 'package:postsapp/core/strings/message.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/domain/usecases/add_post.dart';
import 'package:postsapp/features/posts/domain/usecases/delete_post.dart';
import 'package:postsapp/features/posts/domain/usecases/update_post.dart';

part 'add_delete_update_posts_event.dart';
part 'add_delete_update_posts_state.dart';

class AddDeleteUpdatePostsBloc
    extends Bloc<AddDeleteUpdatePostsEvent, AddDeleteUpdatePostsState> {
  final UpdatePostUsecase updatePost;
  final AddPostUsecase addPost;
  final DeletePostUsecase deletePost;
  AddDeleteUpdatePostsBloc({
    required this.addPost,
    required this.updatePost,
    required this.deletePost,
  }) : super(AddDeleteUpdatePostsInitial()) {
    on<AddDeleteUpdatePostsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostsState());

        final failureOrDoneMessage = await addPost(event.post);
        emit(
          _eitherDoneMessageOrErrorStateMessage(
            ADD_SUCCESS_MESSAGE,
            failureOrDoneMessage,
          ),
        );
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostsState());

        final failureOrDoneMessage = await updatePost(event.post);
        emit(
          _eitherDoneMessageOrErrorStateMessage(
            UPDATE_SUCCESS_MESSAGE,
            failureOrDoneMessage,
          ),
        );
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostsState());

        final failureOrDoneMessage = await deletePost(event.postId);
        emit(
          _eitherDoneMessageOrErrorStateMessage(
            DELETE_SUCCESS_MESSAGE,
            failureOrDoneMessage,
          ),
        );
      }
    });
  }

  AddDeleteUpdatePostsState _eitherDoneMessageOrErrorStateMessage(
    String message,
    Either<Failure, Unit> either,
  ) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdatePostsState(
        message: _mapFailureToMessage(failure),
      ),
      (posts) => MessageAddDeleteUpdatePostsState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case NetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      case ValidationFailure:
        return VALIDATION_FAILURE_MESSAGE;
      case UnauthorizedFailure:
        return UNAUTHORIZED_FAILURE_MESSAGE;
      case UnknownFailure:
        return UNKNOWN_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
