import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var displayName = FirebaseAuth.instance.currentUser!.email!.split("@").first;

  @override
  Widget build(BuildContext context) {
    //app en background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['Type'] == "message") {
        Navigator.of(context).pushReplacementNamed("getmessages");
      } else if (message.data['Type'] == "categorie") {
        Navigator.of(context).pushReplacementNamed("getcategory");
      }
    });

//app terminée
    getInit() async {
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        if (initialMessage.data['Type'] == "message") {
          Navigator.of(context).pushReplacementNamed("getmessages");
        } else if (initialMessage.data['Type'] == "categorie") {
          Navigator.of(context).pushReplacementNamed("getcategory");
        }
      }
    }

    getInit();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('ISI Event'),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("login", (route) => false);
                },
                icon: Icon(Icons.exit_to_app))
          ]),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 20,
                  ),
                  Text(
                    'Bienvenue dans votre espace administrateur $displayName',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 160, 134, 206)),
                  ),
                  Container(
                    height: 30,
                  ),
                  InkWell(
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          Image.asset(
                            "images/categorie.png",
                            height: 120,
                          ),
                          Text(
                            "Catégories",
                            selectionColor: Colors.deepPurpleAccent,
                          ),
                        ]),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("getcategory");
                    },
                  ),
                  Container(
                    height: 30,
                  ),
                  InkWell(
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          Image.asset(
                            "images/msg.png",
                            height: 120,
                          ),
                          Text(
                            "Messages",
                            selectionColor: Colors.deepPurpleAccent,
                          )
                        ]),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("getmessages");
                    },
                  )
                ],
              ),
            ),
          ])),
    );
  }
}
