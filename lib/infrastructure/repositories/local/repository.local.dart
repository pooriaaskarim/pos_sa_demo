import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

const _themeModeKey = 'themeMode';

class LocalRepository {
  LocalRepository() {
    Hive.initFlutter();
  }

  @protected
  String get _instanceName => 'LocalStorage';

  @protected
  bool get _isOpen => Hive.isBoxOpen(_instanceName);

  @protected
  Future<Box<M>> _openDb<M>() async => _isOpen
      ? Hive.box<M>(_instanceName)
      : await Hive.openBox<M>(
          _instanceName,
          path: kIsWeb ? null : (await getApplicationDocumentsDirectory()).path,
        );

  Future<ThemeMode> getThemeMode() async {
    final Box db = await _openDb();
    final String? themeMode = db.get(_themeModeKey);
    await db.close();
    switch (themeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> persistThemeMode(final ThemeMode themeMode) async {
    final Box<String> db = await _openDb<String>();
    await db.put(
      _themeModeKey,
      themeMode.name,
    );
    await db.close();
  }

  Future<void> clearThemeMode() async {
    final Box db = await _openDb();
    await db.delete(_themeModeKey);
    await db.close();
  }
}
