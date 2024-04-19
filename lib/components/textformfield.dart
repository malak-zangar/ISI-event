import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext ; 
  final TextEditingController mycontroller ; 

  const CustomTextForm({super.key, required this.hinttext, required this.mycontroller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mycontroller ,
      decoration: InputDecoration(
          hintText: hinttext,
          hintStyle:  TextStyle(fontSize: 14, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          filled: true,
          fillColor: Color.fromARGB(255, 228, 216, 230),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 73, 15, 82))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey))),
    );
  }
}