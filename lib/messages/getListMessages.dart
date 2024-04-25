/*import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/messages/editMessage.dart';

class getListMessages extends StatefulWidget {
  const getListMessages({super.key});

  @override
  State<getListMessages> createState() => _getListMessagesState();
}

class _getListMessagesState extends State<getListMessages> {
  List<QueryDocumentSnapshot> data = [];

  bool isLoading = true;

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("messages").orderBy('date',descending: true).get();
    data.addAll(querySnapshot.docs);
    isLoading = false;

    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 160, 134, 206),
        onPressed: () {
          Navigator.of(context).pushNamed("addmessage");
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: IconButton(
              onPressed: () async {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("home", (route) => false);
              },
              icon: Icon(Icons.keyboard_return)),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Liste des messages',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 160, 134, 206)),
            ),
          ),
          Expanded(
            child: isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, mainAxisExtent: 165),
                    itemBuilder: (context, i) {
                      Color cardColor;
                      if (data[i]['priorite'] == 'Elevée') {
                        cardColor = Color.fromARGB(255, 243, 226, 148);
                      } else if (data[i]['priorite'] == 'Moyenne') {
                        cardColor = Color.fromARGB(255, 235, 222, 174);
                      } else {
                        cardColor = Color.fromARGB(255, 243, 238, 220);
                      }

                      return InkWell(
                        onTap: () {
                          _showImageDialog(data[i]['imageUrl']);
                        },
                        onLongPress: () {
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.rightSlide,
                              title: 'Actions',
                              btnCancelText: 'Supprimer',
                              btnOkText: 'Modifier',
                              desc: 'Choisir ce que vous voulez faire',
                              btnCancelOnPress: () async {
                                await FirebaseFirestore.instance
                                    .collection("messages")
                                    .doc(data[i].id)
                                    .delete();
                                Navigator.of(context)
                                    .pushReplacementNamed("getmessages");
                              },
                              btnOkOnPress: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditMessage(
                                          docid: data[i].id,
                                          oldmsg: data[i],
                                        )));
                              }).show();
                        },
                        child: SingleChildScrollView(
                          child: Card(
                            color: cardColor,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(children: [
                                Image.network(
                                  data[i]['imageUrl'],
                                  height: 100,
                                  width: 100,
                                ),
                                Text(
                                  "à : ${data[i]['categorie']}",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Divider(
                                  color: Color.fromARGB(255, 196, 195,
                                      197), // Change the color of the divider if needed
                                  //thickness: 1, // Change the thickness of the divider if needed
                                  // height: 20, // Adjust the height between the title and the divider
                                ),
                                Text(
                                  "${data[i]['objet']}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "${data[i]['corps']}",
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "${data[i]['date']}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic),
                                  textAlign: TextAlign.end,
                                ),
                              ]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: InteractiveViewer(
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}*/

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/messages/editMessage.dart';

class getListMessages extends StatefulWidget {
  const getListMessages({Key? key});

  @override
  State<getListMessages> createState() => _getListMessagesState();
}

class _getListMessagesState extends State<getListMessages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 160, 134, 206),
        onPressed: () {
          Navigator.of(context).pushNamed("addmessage");
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          onPressed: () async {
            Navigator.of(context)
                .pushNamedAndRemoveUntil("home", (route) => false);
          },
          icon: Icon(Icons.keyboard_return),
        ),
        title: const Text('ISI Event'),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Liste des messages',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 160, 134, 206),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("messages")
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final data = snapshot.requireData;
                return GridView.builder(
                  itemCount: data.size,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 165,
                  ),
                  itemBuilder: (context, i) {
                    final message = data.docs[i];
                    Color cardColor;
                    if (message['priorite'] == 'Elevée') {
                      cardColor = Color.fromARGB(255, 243, 226, 148);
                    } else if (message['priorite'] == 'Moyenne') {
                      cardColor = Color.fromARGB(255, 235, 222, 174);
                    } else {
                      cardColor = Color.fromARGB(255, 243, 238, 220);
                    }
                    return InkWell(
                      onTap: () {
                        _showImageDialog(message['imageUrl']);
                      },
                      onLongPress: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: 'Actions',
                          btnCancelText: 'Supprimer',
                          btnOkText: 'Modifier',
                          desc: 'Choisir ce que vous voulez faire',
                          btnCancelOnPress: () async {
                            await FirebaseFirestore.instance.collection("messages") .doc(message.id) .delete();
                            await FirebaseStorage.instance.refFromURL(message['imageUrl']).delete();
                            Navigator.of(context).pushReplacementNamed("getmessages");
                          },
                          btnOkOnPress: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditMessage(
                                docid: message.id,
                                oldmsg: message,
                              ),
                            ));
                          },
                        ).show();
                      },
                                            child: SingleChildScrollView(

                      child: Card(
                        color: cardColor,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Image.network(
                                message['imageUrl'],
                                height: 100,
                                width: 100,
                              ),
                              Text(
                                "à : ${message['categorie']}",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Divider(
                                color: Color.fromARGB(255, 196, 195, 197),
                              ),
                              Text(
                                "${message['objet']}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${message['corps']}",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                "${message['date']}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      ),
                                            ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: InteractiveViewer(
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}

