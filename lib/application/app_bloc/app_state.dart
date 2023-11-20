part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState({
    required this.themeMode,
  });

  final ThemeMode themeMode;

  AppState copyWith({
    final ThemeMode? themeMode,
  });

  @override
  List<Object> get props => [
        themeMode,
      ];
}

/// AppState: initial run
/// defaults to [ThemeMode].system
class InitializingState extends AppState {
  const InitializingState({
    super.themeMode = ThemeMode.system,
  });

  @override
  InitializingState copyWith({
    final ThemeMode? themeMode,
  }) =>
      InitializingState(
        themeMode: themeMode ?? this.themeMode,
      );
}

/// AppState: App is Loaded with proper [ThemeMode]
class InitializedState extends AppState {
  const InitializedState({
    required super.themeMode,
  });

  @override
  InitializedState copyWith({
    final ThemeMode? themeMode,
  }) =>
      InitializedState(
        themeMode: themeMode ?? this.themeMode,
      );
}

/// AppState: Some Error occurred
class ErrorState extends AppState {
  const ErrorState({
    required super.themeMode,
  });
  @override
  ErrorState copyWith({
    final ThemeMode? themeMode,
  }) =>
      ErrorState(
        themeMode: themeMode ?? this.themeMode,
      );
}
