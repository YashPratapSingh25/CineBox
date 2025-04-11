import 'package:cinebox/bloc/home_screen_movies/home_screen_movies_bloc.dart';
import 'package:cinebox/screens/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'bloc/home_screen_movies/home_screen_movies_event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeScreenMoviesBloc()..add(FetchAllMoviesEvent()),
          )
        ],
        child: const BottomNavigation(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
