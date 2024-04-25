import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext;
  final TextEditingController mycontroller;
  final bool sec;
  final String? Function(String?)? validator;

  const CustomTextForm(
      {super.key,
      required this.hinttext,
      required this.mycontroller,
      required this.sec,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    if (sec == true) {
      return TextFormField(
        validator: validator,
        obscureText: sec,
        controller: mycontroller,
        decoration: InputDecoration(
          // icon:const Icon(Icons.lock),
          suffixIcon: IconButton(
            padding: const EdgeInsetsDirectional.only(end: 12.0),
            icon: sec
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
            onPressed: () {},
          ),
          hintText: hinttext,

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
      );
    } else {
      return TextFormField(
        obscureText: sec,
        controller: mycontroller,
        decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            filled: true,
            fillColor: Color.fromARGB(255, 228, 216, 230),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Color.fromARGB(255, 73, 15, 82))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Colors.grey))),
      );
    }
  }
  /*  @override
  Widget build(BuildContext context) {
    return PasswordField(
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
  }*/
}
