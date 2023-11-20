import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'application/app_bloc/app_bloc.dart';
import 'firebase_options.dart';
import 'infrastructure/repositories/local/repository.local.dart';
import 'infrastructure/repositories/network/firebase_apis.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (final context) => LocalRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (final context) => AppBloc(
              localRepository: RepositoryProvider.of<LocalRepository>(context),
            ),
          ),
        ],
        child: const App(),
      ),
    ),
  );
}
