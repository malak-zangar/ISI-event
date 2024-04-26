import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class getListCategorie extends StatefulWidget {
  const getListCategorie({Key? key});

  @override
  State<getListCategorie> createState() => _getListCategorieState();
}

class _getListCategorieState extends State<getListCategorie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 160, 134, 206),
        onPressed: () {
          Navigator.of(context).pushNamed("addcategory");
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
              'Liste des catégories',
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
                  .collection("categories")
                  .orderBy('name', descending: false)
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
                    mainAxisExtent: 160,
                  ),
                  itemBuilder: (context, i) {
                    final category = data.docs[i];
                    return InkWell(
                      onLongPress: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: 'Confirmation',
                          desc:
                              'Voulez-vous vraiment supprimer cette catégorie ?',
                          btnCancelText: 'Annuler',
                          btnCancelOnPress: () {},
                          btnOkText: 'Oui',
                          btnOkOnPress: () async {
                            await FirebaseFirestore.instance
                                .collection("categories")
                                .doc(category.id)
                                .delete();
                          },
                        ).show();
                      },
                      child: Card(
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
                              Text("${category['name']}")
                            ],
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
}
