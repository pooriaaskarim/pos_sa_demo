part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}

class InitializeEvent extends NotificationsEvent {
  @override
  List<Object?> get props => [];
}

class RequestNotificationEvent extends NotificationsEvent {
  const RequestNotificationEvent({
    required this.request,
  });

  final Map<String, dynamic> request;
  @override
  List<Object?> get props => [request];
}
