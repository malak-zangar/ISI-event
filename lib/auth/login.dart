import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/custombuttonauth.dart';
import 'package:flutter_application_2/components/textformfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

@override
  State<Login> createState()=> _LoginState();
}

class _LoginState extends State<Login>{

 TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: const Text('ISI Event'),

    ),
          body: Container(
          padding: const EdgeInsets.all(20),
        child: ListView(children:[Column(
    
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Image.asset("images/login.png",height:120),
          Container(height: 30,),

           const  Text(
              'Authentification',
             // style: Theme.of(context).textTheme.headlineMedium,
               style: TextStyle(fontSize:30,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 160, 134, 206)),
            ),
          Container(height: 30,),

          Container(  alignment: Alignment.topLeft,  
          child : const Text("Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),),
          Container(height: 10),
          CustomTextForm(
                  hinttext: "ُEntrer votre Email", mycontroller: email),
          Container(height: 10),
     Container(  alignment: Alignment.topLeft,  
         child :  const Text("Mot de passe",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                 ),),
              Container(height: 10),
              CustomTextForm(
                  hinttext: "ُEntrer votre mot de passe", mycontroller:password ),
           
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
   CustomButtonAuth(title: "Se connecter", onPressed: () {}),
           Container(height: 20),


          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("signup") ; 
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Vous n'avez pas de compte ? ",
                ),
                TextSpan(
                    text: "Créer",
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold)),
              ])),
            ),
          )
          ],


        ),
          ])
      ),
  //  body: Container(),
  );
  }
}
