import 'package:challenge_2/home_page.dart';
import 'package:challenge_2/reusuable_text_field.dart';
import 'package:challenge_2/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class LoginPage extends StatefulWidget {
   LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
TextEditingController _passwordTextController = TextEditingController();

  TextEditingController _emailTextController = TextEditingController();

  final _formkey = GlobalKey<FormState>();


String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'E-mail address is required.';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty)
    return 'Password is required.';

  return null;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black26,
      body:  SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Image(image: AssetImage('assets/images/OOPL-Cinemas-logo-white-website-logo-web.png')),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 100,right: 230, left: 20,),
                child: Text('Log In',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Colors.white,
                  ),),
              ),

              Form(
                key: _formkey,

                child: Column(
                  children: [
                    SizedBox(height: 20,),

                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: reusuableTextField('Email Address', Icons.person_outline, false, _emailTextController, validateEmail),
                    ),

                    SizedBox(height: 20,),

                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: reusuableTextField('Password', Icons.lock_outlined, true, _passwordTextController, validatePassword ),
                    ),

                    SizedBox(height: 40,),

                    signInSignUpButton( true, (){
                      if (_formkey.currentState!.validate()) {
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text).then((value)

                        {Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomePage()));
                        print('signed in');
                        }).onError((error, stackTrace) {
                          print('error ${error.toString()}');
                        });
                      }
                    }),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an Account ? ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    color: Colors.white),),

                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      //   try{
                      //     await FirebaseFirestore.instance.collection('user').add({
                      //       'title':'sdsdssdds',
                      //       'description':'sdsddds',
                      //     });
                      //
                      //     var data = await FirebaseFirestore.instance.collection('user').get();
                      //     print(data);
                      //   }catch(e){
                      //     print('error $e');
                      //   }
                      // },
                      child: Text('Sign Up',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),


    );
  }
}
