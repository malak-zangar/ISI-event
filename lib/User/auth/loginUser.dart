import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/custombuttonauth.dart';
import 'package:flutter_application_2/components/textformfield.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ISI Event'),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
            Form(
              key: formState,
              child: Column(
                //   Container(height: 20,),

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("images/login.png", height: 110),
                  Container(
                    height: 30,
                  ),
                  const Text(
                    'Authentification',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 160, 134, 206)),
                  ),
                  Container(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Email",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(height: 10),
                  CustomTextForm(
                      hinttext: "ُEntrer votre Email",
                      mycontroller: email,
                      sec: false,
                      validator: (val) {
                        if (val == "") {
                          return "obligatoire";
                        }
                      }),
                  Container(height: 10),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Mot de passe",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(height: 10),
                  CustomTextForm(
                      hinttext: "ُEntrer votre mot de passe",
                      mycontroller: password,
                      sec: true,
                      validator: (val) {
                        if (val == "") {
                          return "obligatoire";
                        }
                      }),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    alignment: Alignment.topRight,
                    child: const Text(
                      "Mot de passe oublié ?",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  CustomButtonAuth(
                      title: "Se connecter",
                      onPressed: () async {
                        if (formState.currentState!.validate()) {
                          try {
                            final credential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email.text, password: password.text);

                            Navigator.of(context)
                                .pushReplacementNamed('homeuser');
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: 'Email non existant.',
                              ).show();
                            } else if (e.code == 'wrong-password') {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Erreur',
                                desc: 'Mot de passe érroné.',
                              ).show();
                            }
                          }
                        } else {
                          print("Non Valide");
                        }
                      }),
                  Container(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("signupuser");
                    },
                    child: const Center(
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                          text: "Vous n'avez pas de compte ? ",
                        ),
                        TextSpan(
                            text: "Créer",
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold)),
                      ])),
                    ),
                  )
                ],
              ),
            ),
          ])),
    );
  }
}
