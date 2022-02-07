import 'package:accordion_challenge/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/blocObserver.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lodgify - Flutter Technical Challenge ',
      theme: ThemeData(fontFamily: 'Source Sans Pro'),
      home: Home(),
    );
  }
}
