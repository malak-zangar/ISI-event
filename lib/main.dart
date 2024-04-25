import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('************User is currently signed out!');
      } else {
        print('*************User is signed in!');
      }
    });
  }

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
    /*  home: FirebaseAuth.instance.currentUser == null
          ? Login()
          : Home(),*/

            home: FirebaseAuth.instance.currentUser == null
          ? LoginUser()
          : HomeUser(),



      routes: {
        "signup": (context) => Signup(),
        "login": (context) => const Login(),
        "getcategory": (context) => getListCategorie(),
        "addcategory": (context) => AddCategory(),
        "home": (context) => Home(),
        "getmessages":(context)=> getListMessages(),
        "addmessage":(context)=> AddMessage(),

        "signupuser": (context) => SignupUser(),
        "loginuser": (context) => const LoginUser(),
        "getcategoryuser": (context) => getListCategorieUser(),
        "getmessagesuser":(context)=> getListMessagesUser(),
        "homeuser": (context) => HomeUser(),


      },
    );
  }
}
