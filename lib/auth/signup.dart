import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/custombuttonauth.dart';
import 'package:flutter_application_2/components/textformfield.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

@override
  State<Signup> createState()=> _SignupState();
}

class _SignupState extends State<Signup>{

 TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController username = TextEditingController();

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
    
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
           Image.asset("images/signup.png",height:80),
          Container(height: 30,),

           const  Text(
              'Inscription',
             // style: Theme.of(context).textTheme.headlineMedium,
               style: TextStyle(fontSize:30,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 160, 134, 206)),
            ),
          Container(height: 30,),
  Container(  alignment: Alignment.topLeft,  
              child: const Text("Nom d'utilisateur",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
               ),),
          Container(height: 10),
          CustomTextForm(
                  hinttext: "ُEntrer votre nom d'utilisateur", mycontroller: username),
          Container(height: 10),
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
               Container(height: 20),

   CustomButtonAuth(title: "Créer", onPressed: () {}),
           Container(height: 20),


          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("login") ; 
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Vous avez déja un compte ? ",
                ),
                TextSpan(
                    text: "Se connecter",
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

