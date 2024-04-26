import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/custombuttonauth.dart';
import 'package:flutter_application_2/components/textformfield.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset("images/signup.png", height: 120),
                  Container(
                    height: 30,
                  ),
                  const Text(
                    'Inscription',
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
                      "Nom d'utilisateur",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(height: 10),
                  CustomTextForm(
                      hinttext: "ُEntrer votre nom d'utilisateur",
                      mycontroller: username,
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
                  Container(height: 20),
                  CustomButtonAuth(
                      title: "Créer",
                      onPressed: () async {
                        if (formState.currentState!.validate()) {
                          try {
                            final credential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: email.text,
                              password: password.text,
                            );
                            Navigator.of(context).pushReplacementNamed('login');
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'email-already-in-use') {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Erreur',
                                desc: 'Un compte avec cet email existe déja.',
                              ).show();
                            } else if (e.code == 'weak-password') {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Erreur',
                                desc: 'Mot de passe fragile.',
                              ).show();
                            }
                          } catch (e) {
                            print(e);
                          }
                        } else {
                          print("Non Valide");
                        }
                      }),
                  Container(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed("login");
                    },
                    child: const Center(
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                          text: "Vous avez déja un compte ? ",
                        ),
                        TextSpan(
                            text: "Se connecter",
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
