import 'package:flutter/material.dart';
import 'package:fusetek_movies/services/auth.dart';
import 'package:fusetek_movies/ui/widgets/defaultToast.dart';
import 'package:fusetek_movies/ui/widgets/default_field.dart';
import 'package:fusetek_movies/ui/widgets/progress_dialog.dart';
import 'package:fusetek_movies/ui/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key? key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final auth = Provider.of<Auth>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SafeArea(child: titleText('Bienvenido')),
              const SizedBox(height: 20),
              Image.asset(
                'assets/undraw_home_cinema.png',
                width: 160,
              ),
              const SizedBox(height: 40),
              DefaultField(
                controller: userController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              DefaultField(
                controller: passwordController,
                hintText: 'contraseña',
                obscureText: true,
              ),
              const SizedBox(height: 40),
              TextButton(
                child: Container(
                  width: double.infinity,
                  child: const Center(
                    child: Text(
                      'Iniciar sesion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,
                  onSurface: Colors.yellow,
                  side: const BorderSide(color: Colors.black, width: 2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                onPressed: () {
                  ProgressDialog progressDialog =
                      ProgressDialog(context, message: "Iniciando sesión...");
                  progressDialog.show();
                  if (userController.text != '' &&
                      passwordController.text != '') {
                    auth.singIn(
                        userController.text.trim(), passwordController.text);
                    progressDialog.dismiss();
                  } else {
                    showToast('Rellene todos los campos');
                    progressDialog.dismiss();
                  }
                },
              ),
              TextButton(
                child: Container(
                  width: double.infinity,
                  child: const Center(
                    child: Text(
                      'Crear cuenta',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  onSurface: Colors.yellow,
                  side: const BorderSide(color: Colors.black, width: 2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
