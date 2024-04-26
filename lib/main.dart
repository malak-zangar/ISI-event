//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/User/auth/loginUser.dart';
import 'package:flutter_application_2/User/auth/signupUser.dart';
import 'package:flutter_application_2/auth/login.dart';
import 'package:flutter_application_2/auth/signup.dart';
import 'package:flutter_application_2/categories/addcategorie.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:flutter_application_2/categories/getListCategorie.dart';
import 'package:flutter_application_2/User/categories/getListCategorieUser.dart';
import 'package:flutter_application_2/User/messages/getListMessagesUser.dart';
import 'package:flutter_application_2/home.dart';
import 'package:flutter_application_2/User/homeUser.dart';
import 'package:flutter_application_2/messages/getListMessages.dart';
import 'package:flutter_application_2/messages/addmessage.dart';

Future<void> main() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("------------------On-------------------------");
      print("Type : ${message.data['Type']}");
      print(message.notification!.title);
      print(message.notification!.body);
      print("Objet : ${message.data['Objet']}");
      print("Catégorie : ${message.data['Catégorie']}");
      print("Corps : ${message.data['Corps']}");
      print("-------------------------------------------");
    }
  });
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('************Utilisateur déconnecté!');
    } else {
      print('*************Utilisateur connecté!');
    }
  });
  getToken();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("------------------back-------------------------");
  print("Type : ${message.data['Type']}");
  print(message.notification!.title);
  print(message.notification!.body);
  print("Objet : ${message.data['Objet']}");
  print("Catégorie : ${message.data['Catégorie']}");
  print("Corps : ${message.data['Corps']}");
  print("-------------------------------------------");
}

getToken() async {
  String? mytoken = await FirebaseMessaging.instance.getToken();
  print("*****************************");
  print(mytoken);
  print("*****************************");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ISI Event',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      /* home: FirebaseAuth.instance.currentUser == null
          ? Login()
          : Home(),
*/
      home:
          FirebaseAuth.instance.currentUser == null ? LoginUser() : HomeUser(),
      routes: {
        "signup": (context) => Signup(),
        "login": (context) => const Login(),
        "getcategory": (context) => getListCategorie(),
        "addcategory": (context) => AddCategory(),
        "home": (context) => Home(),
        "getmessages": (context) => getListMessages(),
        "addmessage": (context) => AddMessage(),
        "signupuser": (context) => SignupUser(),
        "loginuser": (context) => const LoginUser(),
        "getcategoryuser": (context) => getListCategorieUser(),
        "getmessagesuser": (context) => getListMessagesUser(),
        "homeuser": (context) => HomeUser(),
      },
    );
  }
}
