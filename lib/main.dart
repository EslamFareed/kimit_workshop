import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kimit_workshop/db/dio/dio_helper.dart';
import 'package:kimit_workshop/db/shared_prefs/prefs_helper.dart';
import 'package:kimit_workshop/firebase_options.dart';
import 'package:kimit_workshop/root/app_root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Future.wait([
    PrefsHelper.init(),
  ]);
  DioHelper.init();

  runApp(const AppRoot());
}
