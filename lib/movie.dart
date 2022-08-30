import 'package:challenge_2/signup.dart';
import 'package:challenge_2/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class movie extends StatefulWidget  {
  const movie({Key? key}) : super(key: key);

  @override
  State<movie> createState() => _movieState();
}

class _movieState extends State<movie> {

  final TextEditingController _titleTextController = TextEditingController();

  final TextEditingController _descriptionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                reusuableTextField2(
                  'Movie Title', Icons.person_outline, _titleTextController,),
                SizedBox(height: 20,),
                reusuableTextField2('Movie Description', Icons.person_outline,
                    _descriptionTextController),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: theContainer('Upload movie'),
                      onTap: () async {
                        try {
                          await FirebaseFirestore.instance.collection('Users')
                              .add({
                            'title': _titleTextController.text,
                            'description': _descriptionTextController.text,
                          });
                          print('new movie added');

                          // final user = User(
                          //   name: titleTextController.text,
                          //   description: descriptionTextController.text,
                          // );
                          //
                          // createUser(user);
                        } catch(e){
                            print('error $e');

                          // await FirebaseFirestore.instance.collection('users').add({
                          //   'title':titleTextController.text,
                          //   'description':descriptionTextController.text,
                          // });


                          // var data = await FirebaseFirestore.instance.collection('user').get();
                          //      print(data);
                          //
                          // MaterialPageRoute(builder: (context) => SignUp()));
                        }
                        Navigator.pop(context);
                      }),
                    InkWell(
                      child: theContainer('Input Image'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },),
                  ],
                )

              ]
          ),
        ),

      ),
    );
  }

  // Future createUser(User user) async {
  //   final docUser = FirebaseFirestore.instance.collection('Users').doc();

    // user({ String id, required String name, required String description}) {}

//     class User {
//   String id;
//   final String name;
//   final String description;
//
//   User({
//     this.id = '',
//     required this.name,
//     required this.description,
// })
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'name': name,
//     'description': description
//   };
// }

  //   user.id = docUser.id;
  //   final json = user.toJson();
  //   await docUser.set(json);
  // }

//    await docUser.set(json);
// }

//

  TextFormField reusuableTextField2(String text, IconData icon,
      TextEditingController controller) {
    return TextFormField(
      controller: controller,
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
    );
  }

  Container theContainer(String text) {
    return Container(
      child: Text(text),
    );
  }


}