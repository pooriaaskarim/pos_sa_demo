part of home;

extension ThemeModeExtension on ThemeMode {
  IconData get icon {
    switch (this) {
      case ThemeMode.system:
        return Icons.brightness_auto;
      case ThemeMode.light:
        return Icons.brightness_7_sharp;
      case ThemeMode.dark:
        return Icons.brightness_4_outlined;
    }
  }
}

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(final BuildContext context) => BlocBuilder<AppBloc, AppState>(
        builder: (final context, final state) => IconButton(
          onPressed: () {
            BlocProvider.of<AppBloc>(context).add(ToggleThemeMode());
          },
          icon: Icon(state.themeMode.icon),
        ),
      );
}
