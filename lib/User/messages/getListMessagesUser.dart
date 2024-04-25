/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class getListMessagesUser extends StatefulWidget {
  const getListMessagesUser({super.key});

  @override
  State<getListMessagesUser> createState() => _getListMessagesUserState();
}

class _getListMessagesUserState extends State<getListMessagesUser> {
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
   
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: IconButton(
              onPressed: () async {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("homeuser", (route) => false);
              },
              icon: Icon(Icons.keyboard_return)),
          title: const Text('ISI Event'),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("loginuser", (route) => false);
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
                                      197), 
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
}
*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class getListMessagesUser extends StatelessWidget {
  const getListMessagesUser({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          onPressed: () async {
            Navigator.of(context).pushNamedAndRemoveUntil(
                "homeuser", (route) => false);
          },
          icon: Icon(Icons.keyboard_return),
        ),
        title: const Text('ISI Event'),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "loginuser", (route) => false);
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
              'Vos messages',
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

                // Obtenez les catégories de la collection de l'utilisateur authentifié
               // var userCategories = getUserCategories();
                final messages = snapshot.data!.docs;

           return FutureBuilder<List<String>>(
                  future: getUserCategories(),
                  builder: (context, userCategoriesSnapshot) {
                    if (userCategoriesSnapshot.connectionState ==
                            ConnectionState.waiting ||
                        !userCategoriesSnapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final userCategories = userCategoriesSnapshot.data!;

                    // Filtrer les messages pour ceux dont la catégorie est dans la collection de l'utilisateur
                    var filteredMessages = messages.where((message) {
                      return userCategories.contains(message['categorie']);
                    }).toList();

                return GridView.builder(
                  itemCount: filteredMessages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 165,
                  ),
                  itemBuilder: (context, i) {
                    Color cardColor;
                    if (filteredMessages[i]['priorite'] == 'Elevée') {
                      cardColor = Color.fromARGB(255, 243, 226, 148);
                    } else if (filteredMessages[i]['priorite'] == 'Moyenne') {
                      cardColor = Color.fromARGB(255, 235, 222, 174);
                    } else {
                      cardColor = Color.fromARGB(255, 243, 238, 220);
                    }

                    return InkWell(
                      onTap: () {
                        _showImageDialog(context, filteredMessages[i]['imageUrl']);
                      },
                      child: SingleChildScrollView(
                        child: Card(
                          color: cardColor,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Image.network(
                                  filteredMessages[i]['imageUrl'],
                                  height: 100,
                                  width: 100,
                                ),
                                Text(
                                  "à : ${filteredMessages[i]['categorie']}",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Divider(
                                  color: Color.fromARGB(255, 196, 195, 197),
                                ),
                                Text(
                                  "${filteredMessages[i]['objet']}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "${filteredMessages[i]['corps']}",
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "${filteredMessages[i]['date']}",
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
                  
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  void _showImageDialog(BuildContext context, String imageUrl) {
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
Future<List<String>> getUserCategories() async {
  // Récupérez l'ID de l'utilisateur authentifié
  var userId = FirebaseAuth.instance.currentUser?.uid;

  // Obtenez les catégories de la collection de l'utilisateur authentifié
  var collectionRef = FirebaseFirestore.instance.collection("collection");
  var snapshot = await collectionRef.where("user", isEqualTo: userId).get();

  // Convertir les données dynamiques en une liste de chaînes
  List<String> categories = [];
  snapshot.docs.forEach((doc) {
    categories.add(doc['category']);
  });

  return categories;
}
}

