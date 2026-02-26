part of 'add_delete_update_posts_bloc.dart';

sealed class AddDeleteUpdatePostsState extends Equatable {
  const AddDeleteUpdatePostsState();

  @override
  List<Object> get props => [];
}

final class AddDeleteUpdatePostsInitial extends AddDeleteUpdatePostsState {}

final class LoadingAddDeleteUpdatePostsState
    extends AddDeleteUpdatePostsState {}

final class ErrorAddDeleteUpdatePostsState extends AddDeleteUpdatePostsState {
  final String message;
  const ErrorAddDeleteUpdatePostsState({required this.message});
  @override
  List<Object> get props => [message];
}

final class MessageAddDeleteUpdatePostsState extends AddDeleteUpdatePostsState {
  final String message;
  const MessageAddDeleteUpdatePostsState({required this.message});
  @override
  List<Object> get props => [message];
}
