import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fullfirebase/pages/signup.dart';

class UiHelper{

  static CustomTextField(TextEditingController controller,String text,String label,IconData iconData, bool toHide){
    return TextFormField(
      controller: controller,
      obscureText: toHide,
      decoration: InputDecoration(
        hintText: text,
        labelText: label,
        prefixIcon: Icon(iconData),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        )
      ),
    );
  }

}