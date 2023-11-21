import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'application/app_bloc/app_bloc.dart';
import 'application/notifications_bloc/notifications_bloc.dart';
import 'firebase_options.dart';
import 'infrastructure/repositories/local/repository.local.dart';
import 'infrastructure/repositories/network/firebase.repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (final context) => LocalRepository(),
        ),
        RepositoryProvider(
          create: (final context) => FirebaseRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (final context) => AppBloc(
              localRepository: RepositoryProvider.of<LocalRepository>(context),
            ),
          ),
          BlocProvider(
            create: (final context) => NotificationsBloc(
              firebaseRepository:
                  RepositoryProvider.of<FirebaseRepository>(context),
            ),
          ),
        ],
        child: const App(),
      ),
    ),
  );
}
