import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/custombuttonauth.dart';
import 'package:flutter_application_2/components/customtextfieldadd.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddMessage extends StatefulWidget {
  const AddMessage({super.key});

  @override
  State<AddMessage> createState() => _AddMessageState();
}

sendNotif() async{
var headers = {
  'Accept': '"/"',
  'Content-type': 'application/json',
  'Authorization': 'key=AAAAdY4Z3t8:APA91bGsedQoogY21cGoSQY-kdyWtQB8Vyr4fodVxNOdPpHb8D9vi6r9H4lLFp_DsMIo0h8UW2ptaD2RCUmS0oUmS65pRYfo60XzCIpHUxtjXHbiYW3U29VL_Ta9R6gY-R_6MWWQfoi0'
};
var request = http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
request.body = json.encode({
  "to": "d42S0zDJTR6BhH0Y6aCzXo:APA91bFv-3tE-rKAK48ne6THChgx0EcXfEfAwKqONNGsKm8vkbRID5KUpSSPxVFetHq3SjhwFsQ37_aLEo0BNsYcwH6ZTT1KfDql5-IApUdnLEmdDDJOgNu_5_DJmQIjIeRxWbNTJict",
  "notification": {
    "title": "ISI Event",
    "body": "Salut, vous avez recu un nouveau message de la part de l'ISI, merci de le consulter :) ."
  }
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print("teb3ATH");
  print(await response.stream.bytesToString());
}
else {
  print(response.reasonPhrase);
}

}

class _AddMessageState extends State<AddMessage> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController objet = TextEditingController();
  TextEditingController corps = TextEditingController();
  TextEditingController priorite = TextEditingController();
  TextEditingController categorie = TextEditingController();

  DateTime now = DateTime.now();
  var date;
  late String  _selectedPriority ="Moyenne";
  late String  _selectedCategory = "Tous";

  late XFile? _imageFile; // Utilisez XFile pour stocker le chemin de l'image sélectionnée


  CollectionReference messages =FirebaseFirestore.instance.collection("messages");
CollectionReference categories =  FirebaseFirestore.instance.collection("categories");

// Fonction pour récupérer les catégories depuis Firestore
  Future<List<String>> getCategories() async {
    QuerySnapshot querySnapshot = await categories.get();

    return querySnapshot.docs.map((doc) => doc.get('name').toString()).toList();
  }

  addMessage() async {
    if (formState.currentState!.validate()) {
      try {
        date="${now.year}/${now.month}/${now.day} -- ${now.hour}:${now.minute}";
      
        DocumentReference response = await messages.add({"objet": objet.text,"corps": corps.text,
        "priorite": _selectedPriority ,"date": date,
        "categorie": _selectedCategory});

          if (_imageFile != null) {
        final storageRef = FirebaseStorage.instance.ref().child('images').child(DateTime.now().toString() + '.jpg');
        await storageRef.putFile(File(_imageFile!.path));

        final imageUrl = await storageRef.getDownloadURL();

        await response.update({'imageUrl': imageUrl});
      }
       sendNotif();
        Navigator.of(context).pushReplacementNamed("getmessages");
      } catch (e) {
        print("Error $e ");
      }
    }
  }

  Future<void> _pickImage() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  setState(() {
    _imageFile = pickedImage;
  });
}


   Widget _buildDropdownFormField({
    required String label,
    required String hintText,
    required String value,
    required List<String> items,
    void Function(String?)? onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            filled: true,
            fillColor: Color.fromARGB(255, 228, 216, 230),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Color.fromARGB(255, 73, 15, 82)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          value: value,
          items: items.map((item) {
            return DropdownMenuItem(
              child: Text(item),
              value: item,
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading:IconButton(
                onPressed: () async {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("getmessages", (route) => false);
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
  body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
       Form(
        key: formState,
        child: Column(children: [
          Container(
            height: 15,
          ),
          const Text(
            'Ajouter un message',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 160, 134, 206)),
          ),
          Container(
            height: 30,
          ),

        FutureBuilder<List<String>>(
                    future: getCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        return Text('Erreur de chargement des catégories + ${snapshot.error}');
                      }

                      List<String>? categoryNames = snapshot.data;

                      return _buildDropdownFormField(
                        label: 'Catégorie',
                        hintText: 'Choisir une catégorie',
                        value: _selectedCategory,
                        items: categoryNames!,
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Veuillez sélectionner une catégorie';
                          }
                          return null;
                        },
                      );
                    },
                  ),

Container(height:15),
                 
            Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Priorité",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                    Container(
            height: 10,
          ),
 
          Container(
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          hintText: 'Choisir une priorité',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          filled: true,
          fillColor: Color.fromARGB(255, 228, 216, 230),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Color.fromARGB(255, 73, 15, 82))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey)),
        ),
        value: _selectedPriority ,
        items: [
          DropdownMenuItem(
            child: Text('Elevée'),
            value: 'Elevée',
          ),
          DropdownMenuItem(
            child: Text('Moyenne'),
            value: 'Moyenne',
          ),
 DropdownMenuItem(
            child: Text('Faible'),
            value: 'Faible',
          ),        ],
        onChanged: (value) {
         setState(() {
      _selectedPriority  = value.toString(); // Mettre à jour _selectedPriority  avec la nouvelle valeur sélectionnée
    });
        },
        validator: (value) {
          if (value == null) {
            return 'Veuillez sélectionner une priorité';
          }
          return null;
        },
      ),
      ),
      Container(
            height: 20,
          ),
   Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Objet ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
            height: 10,
          ),
          Container(
            child: CustomTextFormAdd(
                hinttext: "Entrer l'objet du message",
                mycontroller: objet,
                validator: (val) {
                  if (val == "") {
                    return "Obligatoire";
                  }
                }),
          ),
 Container(
            height: 15,
          ),
                    Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Corps ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                    Container(
            height: 10,
          ),
          Container(
            child: TextField(
              keyboardType: TextInputType.multiline, // Permettre plusieurs lignes de texte
                maxLines: null, 
                decoration: InputDecoration(
                   hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          filled: true,
          fillColor: Color.fromARGB(255, 228, 216, 230),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Color.fromARGB(255, 73, 15, 82))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey)),
                  hintText: 'Entrer votre message',
                  
                ),
                 controller: corps,
               ),  
          ),
Container(
            height: 15,
          ),

ElevatedButton(
  onPressed: _pickImage,
  child: Text('Ajouter une image'),
),
Container(
            height: 30,
          ),

          CustomButtonAuth(
            title: "Ajouter",
            onPressed: () {
              addMessage();
            },
          )
        ]),
      ),
        ])),
    );
    
  }
}
