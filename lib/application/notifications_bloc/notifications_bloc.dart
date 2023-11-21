import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../infrastructure/repositories/network/firebase.repository.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc({
    required final FirebaseRepository firebaseRepository,
  })  : _firebaseRepository = firebaseRepository,
        super(const InitializingState()) {
    on<InitializeEvent>(_initialize);
    on<RequestNotificationEvent>(_requestNotification);
  }

  final FirebaseRepository _firebaseRepository;
  late String _fcmToken;

  FutureOr<void> _initialize(
    final InitializeEvent event,
    final Emitter<NotificationsState> emit,
  ) async {
    Future<void> initFcmToken() async {
      final fcmTokenOrException = await _firebaseRepository.getFcmToken();

      fcmTokenOrException.fold(
        (final l) {
          emit(ErrorOnInitializingState(l));
          throw l;
        },
        (final r) => _fcmToken = r,
      );
    }

    Future<void> registerOnTokenRefresh() async {
      FirebaseMessaging.instance.onTokenRefresh.listen((final fcmToken) {
        _fcmToken = fcmToken;
      }).onError((final err) {
        emit(ErrorOnInitializingState(err));
      });
      await FirebaseMessaging.instance.setAutoInitEnabled(true);
    }

    await initFcmToken();
    await registerOnTokenRefresh();

    emit(const IdleState());
  }

  FutureOr<void> _requestNotification(
    final RequestNotificationEvent event,
    final Emitter<NotificationsState> emit,
  ) async {
    emit(
      const RequestingState(),
    );

    final Map<String, dynamic> map = Map<String, dynamic>.from(event.request);
    map['to'] = _fcmToken;

    final response = await _firebaseRepository.requestAndroidNotification(
      jsonEncode(map),
    );

    response.fold(
      (final l) => emit(
        ErrorState(
          l,
          request: event.request,
        ),
      ),
      (final r) => emit(const IdleState()),
    );
  }
}
