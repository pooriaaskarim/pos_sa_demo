import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app.dart';
import '../../../../../infrastructure/config/theme/app.fonts.dart';
import '../../../../application/notifications_bloc/notifications_bloc.dart';

const _dismissibleRequest = <String, dynamic>{
  'notification': <String, dynamic>{
    'body': 'You can dismiss this one!',
    'title': 'Dismissible Notifier',
  },
  'priority': 'high',
  'data': <String, dynamic>{'button': 'Dismiss'},
};

class NotificationsTab extends StatefulWidget {
  const NotificationsTab({super.key});

  @override
  State<NotificationsTab> createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {
  late NotificationsBloc _notificationsBloc;

  Future<void> _initAwesomeNotification() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'defaultChannel',
        channelName: 'Default',
        channelDescription: 'Channel made for Demo',
      ),
    ]);
    FirebaseMessaging.onMessage.listen(
      (final event) {
        debugPrint(event.toString());
        debugPrint(event.toMap().toString());

        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: int.tryParse(event.messageId ?? '1') ?? 1,
            channelKey: 'defaultChannel',
            title: event.notification?.title,
            body: event.notification?.body,
            bigPicture: event.notification?.android?.imageUrl,
          ),
          actionButtons: [
            ...event.data.entries.map(
              (final e) => NotificationActionButton(
                key: e.key,
                label: e.value,
                actionType: ActionType.DismissAction,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationsBloc = BlocProvider.of<NotificationsBloc>(context);
    _initAwesomeNotification();
    _notificationsBloc.add(InitializeEvent());
  }

  @override
  void didChangeDependencies() {
    _notificationsBloc = BlocProvider.of<NotificationsBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocConsumer<NotificationsBloc, NotificationsState>(
      listener: (
        final context,
        final state,
      ) {
        if (state is ErrorOnInitializingState) {
          _showErrorOnInitDialog(context);
        }
      },
      builder: (final context, final state) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: state is RequestingState
                ? null
                : () {
                    BlocProvider.of<NotificationsBloc>(context).add(
                      const RequestNotificationEvent(
                        request: _dismissibleRequest,
                      ),
                    );
                  },
            child: Text(
              'Try\nDismissible Notification',
              style: themeData.textTheme.labelLarge
                  ?.copyWith(color: themeData.colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorOnInitDialog(final BuildContext context) {
    showDialog(
      context: context,
      builder: (final context) {
        final ThemeData themeData = Theme.of(context);

        return AlertDialog(
          content: const Text('There was a problem connecting to firebase.'),
          actions: [
            TextButton(
              onPressed: App.navigator?.pop,
              child: Text(
                'Dismiss',
                style: themeData.textTheme.labelLarge
                    ?.copyWith(fontWeight: AppFonts.light),
              ),
            ),
            TextButton(
              onPressed: () => _notificationsBloc.add(InitializeEvent()),
              child: Text(
                'Retry',
                style: themeData.textTheme.labelLarge
                    ?.copyWith(color: themeData.colorScheme.primary),
              ),
            ),
          ],
        );
      },
    );
  }
}
