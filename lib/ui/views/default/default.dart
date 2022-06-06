import 'package:flutter/material.dart';
import 'package:fusetek_movies/data/models/user_model.dart';
import 'package:fusetek_movies/services/auth.dart';
import 'package:fusetek_movies/ui/views/login/login.dart';
import 'package:fusetek_movies/ui/views/movies/movies.dart';
import 'package:provider/provider.dart';

class Default extends StatefulWidget {
  Default({Key? key});

  @override
  _DefaultState createState() => _DefaultState();
}

class _DefaultState extends State<Default> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return StreamBuilder<User?>(
        stream: auth.user,
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            return user == null ? Login() : Movies();
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
