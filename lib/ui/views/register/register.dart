import 'package:flutter/material.dart';
import 'package:fusetek_movies/services/auth.dart';
import 'package:fusetek_movies/ui/widgets/defaultToast.dart';
import 'package:fusetek_movies/ui/widgets/default_field.dart';
import 'package:fusetek_movies/ui/widgets/progress_dialog.dart';
import 'package:fusetek_movies/ui/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  Register({Key? key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                titleText('Crea una nueva cuenta.'),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/undraw_online_video.png',
                  width: 160,
                ),
                const SizedBox(height: 40),
                DefaultField(
                  controller: userController,
                  hintText: "Email",
                ),
                const SizedBox(height: 20),
                DefaultField(
                  controller: passwordController,
                  hintText: "Contraseña",
                  obscureText: true,
                ),
                const SizedBox(height: 40),
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
                  onPressed: () async {
                    ProgressDialog progressDialog =
                        ProgressDialog(context, message: "Iniciando sesión...");
                    progressDialog.show();
                    if (userController.text != '' &&
                        passwordController.text != '') {
                      await auth.createUser(
                          userController.text, passwordController.text);
                      progressDialog.dismiss();
                      Navigator.pop(context);
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
                        'Regresar',
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
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
