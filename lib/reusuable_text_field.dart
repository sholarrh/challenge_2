import 'package:flutter/material.dart';

TextFormField reusuableTextField (String text, IconData icon,
bool isPasswordType, TextEditingController controller, validator ) {
  return TextFormField(
    validator: validator,
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9),),
    decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black,),
    labelText: text,

    labelStyle: TextStyle(
        color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,),
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: Colors.white.withOpacity(0.9),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.none,),),
    ),
    keyboardType: isPasswordType
    ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}


Container signInSignUpButton(
bool isLogin, Function onTap) {
  return Container(
    width: double.infinity,
    height: 50,
    margin: EdgeInsets.fromLTRB(0,10,0,20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? 'Log In' : 'Sign UP',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          }
          return Colors.red;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))))
      ),
  );
}