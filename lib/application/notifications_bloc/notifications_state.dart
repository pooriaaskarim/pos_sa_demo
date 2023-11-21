part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();
}

abstract class UnInitializedState extends NotificationsState {
  const UnInitializedState();
}

class InitializingState extends UnInitializedState {
  const InitializingState();
  @override
  List<Object> get props => [];
}

class ErrorOnInitializingState extends UnInitializedState {
  const ErrorOnInitializingState(this.error);
  final Exception error;
  @override
  List<Object> get props => [error];
}

abstract class InitializedState extends NotificationsState {
  const InitializedState();
}

class IdleState extends InitializedState {
  const IdleState();
  @override
  List<Object> get props => [];
}

class RequestingState extends InitializedState {
  const RequestingState();
  @override
  List<Object> get props => [];
}

class ErrorState extends InitializedState {
  const ErrorState(
    this.error, {
    required this.request,
  });

  final Map<String, dynamic> request;
  final Exception error;
  @override
  List<Object?> get props => [
        request,
        error,
      ];
}
