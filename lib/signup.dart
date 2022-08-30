import 'package:challenge_2/home_page.dart';
import 'package:challenge_2/reusuable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController _passwordTextController = TextEditingController();

  TextEditingController _emailTextController = TextEditingController();

  TextEditingController _firstnameTextController = TextEditingController();

  TextEditingController _lastnameTextController = TextEditingController();

  String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty)
      return 'Password is required.';

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formPassword))
      return '''
    Password must be at least 8 characters,
    include an uppercase letter, number and symbol.
    ''';

    return null;
  }

  String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty)
      return 'E-mail address is required.';

    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

    return null;
  }

  String? validateFirstName(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty)
      return 'First Name is required.';

    return null;
  }

  String? validateLastName(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) return 'Last Name is required.';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 50, right: 210, left: 20, bottom: 11),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              reusuableTextField('Enter First Name', Icons.person_outline,
                  false, _firstnameTextController, validateFirstName),
              SizedBox(
                height: 20,
              ),
              reusuableTextField('Enter Last Name', Icons.person_outline, false,
                  _lastnameTextController, validateLastName),
              SizedBox(
                height: 20,
              ),
              reusuableTextField('Enter Your Email', Icons.person_outline,
                  false, _emailTextController, validateEmail),
              SizedBox(
                height: 20,
              ),
              reusuableTextField('Enter Your Password', Icons.lock_outline,
                  true, _passwordTextController, validatePassword),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: signInSignUpButton(false, () async {
                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }).onError((error, stackTrace) {
                    print('error ${error.toString()}');
                  });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
