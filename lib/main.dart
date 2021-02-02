import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/jokes/presentation/bloc/jokes_bloc.dart';
import 'features/jokes/presentation/pages/jokes_page.dart';
import 'injection_container.dart' as di;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  
  runApp(
    BlocProvider(
      create: (_) => di.sl<JokesBloc>(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "title",
      home: JokesPage(),
    );
  }
}
