import 'package:buradayim/pages/splash.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  runApp(const MyApp());

  await GetStorage.init('buradayim');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Buradayım',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const Splash());
  }
}
