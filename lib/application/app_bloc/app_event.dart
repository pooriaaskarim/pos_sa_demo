part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

/// AppEvent: Initializes Doggo's Den: Must be added at App Run
class InitializeApp extends AppEvent {
  @override
  List<Object?> get props => [];
}

/// AppEvent: Switches to next value in [ThemeMode].values
class ToggleThemeMode extends AppEvent {
  @override
  List<Object?> get props => [];
}
