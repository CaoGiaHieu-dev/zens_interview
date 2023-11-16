import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zens_mobile_test/core/utilities/preferences.dart';
import 'package:zens_mobile_test/root.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    await _initServices();
    runApp(const RootApp());
  }, (error, stack) {});
}

Future<void> _initServices() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.setPreferences();
}
