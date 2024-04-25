import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/custombuttonauth.dart';
import 'package:flutter_application_2/components/customtextfieldadd.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");

  addCategory() async {
    if (formState.currentState!.validate()) {
      try {
        DocumentReference response = await categories.add({"name": name.text});
        Navigator.of(context).pushReplacementNamed("getcategory");
      } catch (e) {
        print("Error $e ");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading:IconButton(
                onPressed: () async {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("getcategory", (route) => false);
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
      body: Form(
        key: formState,
        child: Column(children: [
          Container(
            height: 30,
          ),
          const Text(
            'Ajouter catégorie',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 160, 134, 206)),
          ),
          Container(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: CustomTextFormAdd(
                hinttext: "Entrer nom",
                mycontroller: name,
                validator: (val) {
                  if (val == "") {
                    return "Obligatoire";
                  }
                }),
          ),
          CustomButtonAuth(
            title: "Ajouter",
            onPressed: () {
              addCategory();
            },
          )
        ]),
      ),
    );
  }
}
