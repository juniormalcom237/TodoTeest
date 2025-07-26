import 'package:flutter/material.dart';

import 'package:todo_test_app/src/core/application.dart';
import 'src/Feature/Shared/locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const Application());
}
