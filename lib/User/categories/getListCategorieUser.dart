import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class getListCategorieUser extends StatefulWidget {
  const getListCategorieUser({Key? key});

  @override
  State<getListCategorieUser> createState() => _getListCategorieUserState();
}

class _getListCategorieUserState extends State<getListCategorieUser> {
  late Stream<QuerySnapshot> categoryStream;
  late Stream<QuerySnapshot> collectionStream;
  late List<dynamic> categoriesInCollection;

  @override
  void initState() {
    super.initState();
    categoryStream = FirebaseFirestore.instance
        .collection("categories")
        .orderBy('name', descending: false)
        .snapshots();
    getUserCollection();
  }

  Future<void> getUserCollection() async {
    var user = FirebaseAuth.instance.currentUser?.uid;
    var collectionRef = FirebaseFirestore.instance.collection("collection");
    var snapshot = await collectionRef.where("user", isEqualTo: user).get();
    setState(() {
      categoriesInCollection =
          snapshot.docs.map((doc) => doc['category']).toList();
    });

    collectionStream = collectionRef.where("user", isEqualTo: user).snapshots();
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
          icon: Icon(Icons.keyboard_return),
        ),
        title: const Text('ISI Event'),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("loginuser", (route) => false);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Vos catégories',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 160, 134, 206),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: categoryStream,
              builder: (context, categorySnapshot) {
                if (categorySnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (categorySnapshot.hasError) {
                  return Center(
                      child: Text('Error: ${categorySnapshot.error}'));
                }
                final categories = categorySnapshot.data!.docs;
                return StreamBuilder<QuerySnapshot>(
                  stream: collectionStream,
                  builder: (context, collectionSnapshot) {
                    if (collectionSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (collectionSnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${collectionSnapshot.error}'));
                    }

                    // Mettre à jour la liste des catégories de l'utilisateur
                    categoriesInCollection = collectionSnapshot.data!.docs
                        .map((doc) => doc['category'].toString())
                        .toList();

                    return GridView.builder(
                      itemCount: categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 160,
                      ),
                      itemBuilder: (context, i) {
                        bool isCategoryInCollection = categoriesInCollection
                            .contains(categories[i]['name']);

                        return InkWell(
                          onLongPress: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.rightSlide,
                              title: 'Collection',
                              desc: isCategoryInCollection
                                  ? 'Voulez-vous vraiment supprimer cette catégorie de votre collection ?'
                                  : 'Voulez-vous vraiment ajouter cette catégorie à votre collection ?',
                              btnCancelText: 'Annuler',
                              btnCancelOnPress: () {},
                              btnOkText: 'Oui',
                              btnOkOnPress: () async {
                                var user =
                                    FirebaseAuth.instance.currentUser?.uid;
                                var collectionRef = FirebaseFirestore.instance
                                    .collection("collection");
                                if (isCategoryInCollection) {
                                  var doc = await collectionRef
                                      .where("user", isEqualTo: user)
                                      .where("category",
                                          isEqualTo: categories[i]['name'])
                                      .get();
                                  doc.docs
                                      .forEach((doc) => doc.reference.delete());
                                  await FirebaseMessaging.instance
                                      .unsubscribeFromTopic(
                                          categories[i]['name']);
                                } else {
                                  await collectionRef.add({
                                    "user": user,
                                    "category": categories[i]['name']
                                  });
                                  await FirebaseMessaging.instance
                                      .subscribeToTopic(categories[i]['name']);
                                }
                              },
                            ).show();
                          },
                          child: Card(
                            color: isCategoryInCollection
                                ? Color.fromARGB(255, 247, 225, 179)
                                : null,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "images/categorie.png",
                                    height: 90,
                                  ),
                                  Container(
                                    height: 10,
                                  ),
                                  Text("${categories[i]['name']}"),
                                ],
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
}
