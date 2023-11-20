library splash;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app.dart';
import '../../application/app_bloc/app_bloc.dart';
import '../../infrastructure/config/routes/app.route_names.dart';
import '../../infrastructure/utils/app.utils.dart';
import '../shared/widgets/loading.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(final BuildContext context) => BlocConsumer<AppBloc, AppState>(
        listener: (final context, final state) {
          if (state is InitializedState) {
            App.navigator?.pushReplacementNamed(AppRouteNames.home);
          }
        },
        builder: (final context, final state) {
          final themeData = Theme.of(context);

          return Scaffold(
            body: AppUtils.responsiveContent(
              context: context,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Loading(),
                  AppUtils.verticalSpacer(),
                  _buildStateInfo(state, themeData),
                  if (state is ErrorState)
                    _buildRetryButton(context, themeData),
                ],
              ),
            ),
          );
        },
      );

  Widget _buildRetryButton(
    final BuildContext context,
    final ThemeData themeData,
  ) =>
      TextButton(
        onPressed: () {
          BlocProvider.of<AppBloc>(context).add(InitializeApp());
        },
        child: Text(
          'Retry',
          style: themeData.textTheme.labelLarge,
        ),
      );

  Widget _buildStateInfo(final AppState state, final ThemeData themeData) =>
      Text(
        state is InitializingState
            ? "Initializing . . ."
            : state is ErrorState
                ? 'Error occurred'
                : 'Done',
        style: themeData.textTheme.bodyLarge
            ?.copyWith(color: themeData.colorScheme.onBackground),
      );
}
