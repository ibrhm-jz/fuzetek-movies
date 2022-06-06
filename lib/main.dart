import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fusetek_movies/services/auth.dart';
import 'package:fusetek_movies/ui/views/default/default.dart';
import 'package:fusetek_movies/ui/views/login/login.dart';
import 'package:fusetek_movies/ui/views/movies/movies.dart';
import 'package:fusetek_movies/ui/views/register/register.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Auth>(
          create: (_) => Auth(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: [const Locale('es'), const Locale('en')],
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.black,
        ),
        initialRoute: '/default',
        routes: {
          '/movies': (BuildContext context) => Movies(),
          '/default': (BuildContext context) => Default(),
          '/login': (BuildContext context) => Login(),
          '/register': (BuildContext context) => Register(),
        },
      ),
    );
  }
}
