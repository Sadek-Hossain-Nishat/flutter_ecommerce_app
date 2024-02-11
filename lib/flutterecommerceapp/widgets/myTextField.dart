import 'package:flutter/material.dart';
Widget myTextField(String hintText,keyboardType,controller){

  return TextField(

    keyboardType: keyboardType,
    controller: controller,
    style: TextStyle(
      color: Colors.grey
    ),
    decoration: InputDecoration(
      hintText: hintText
    )

  );

}