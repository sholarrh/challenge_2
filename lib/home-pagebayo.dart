import 'dart:io';

import 'package:buylap/page/cart.dart';
import 'package:buylap/page/favourite.dart';
import 'package:buylap/page/home.dart';
import 'package:buylap/page/post.dart';
import 'package:buylap/page/profile.dart';
import 'package:buylap/screens/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart'as Path;




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final StoragePath storage =  StoragePath();
  TextEditingController _name = TextEditingController();

  TextEditingController _desc = TextEditingController();

  TextEditingController _price = TextEditingController();

  final _key = GlobalKey<FormState>();
  bool notLoading = true;
  var imagePath;
  CollectionReference _collectionRef=
  FirebaseFirestore.instance.collection
    ('users-data');
  sendUserName() async {
    return _collectionRef.doc().set({
      'name':_name.text,
      'description':_desc.text,
      'price':_price.text,
      'imagepath':imagePath,
    }).then((value) => Navigator.pop(context)).catchError((error)=>print("something is wrong")) ;
  }
  int curretTab =0;
  final List<Widget> screens = [
    Cart(),
    Profile(),
    Post(),
    Favourite(),
    Home(),
  ];

  final PageStorageBucket bucket =  PageStorageBucket();
  Widget currentScreen = Home();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageStorage(
          child: currentScreen,
            bucket: bucket,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff5956E9),
          child: Icon(Icons.add),
          onPressed: (){
            showModalBottomSheet<void>(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Container(
                  height: 500,
                    color: Colors.red,
                  child:Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 50),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text('Post Laptops',
                                style: GoogleFonts.raleway(
                                    fontSize: 24,
                                    color: Color(0xff5956E9),
                                    fontWeight: FontWeight.w700
                                )),
                            Form(
                              key: _key,
                              child: Column(
                                children: [
                                  SizedBox(height: 30,),
                                  TextFormField(
                                    controller: _name,
                                    validator: (value){
                                      if(value!.isEmpty)
                                        return 'LaptopName field entry is needed';
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        filled: true,
                                        fillColor:Colors.white ,
                                        contentPadding: EdgeInsets.only(left: 10),
                                        hintText: "Laptop Name",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color.fromRGBO( 229, 229, 229, 1), width: 2),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color.fromRGBO( 229, 229, 229, 1), width: 1.5),
                                            borderRadius:  BorderRadius.circular(10)
                                        ),
                                        hintStyle:
                                        GoogleFonts.raleway(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400
                                        )),
                                  ),
                                  SizedBox(height: 20,),
                                  TextFormField(
                                    controller: _desc,
                                    validator: (value){
                                      if(value!.isEmpty)
                                        return 'Description field entry is needed';
                                    },
                                    decoration: InputDecoration(
                                      // prefixIcon: Icon(
                                      //   Icons.messenger_outline,
                                      //   color: Color(0xff5956E9),
                                      // ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        filled: true,
                                        fillColor:Colors.white ,
                                        contentPadding: EdgeInsets.only(left: 10),
                                        hintText: "Description",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color.fromRGBO( 229, 229, 229, 1), width: 2),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color.fromRGBO( 229, 229, 229, 1), width: 1.5),
                                            borderRadius:  BorderRadius.circular(10)
                                        ),
                                        hintStyle:
                                        GoogleFonts.raleway(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400
                                        )),
                                  ),
                                  SizedBox(height: 20,),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _price,
                                    validator: (value){
                                      if(value!.isEmpty)
                                        return 'Price field entry is needed';
                                    },
                                    decoration: InputDecoration(
                                      // prefixIcon: Icon(
                                      //   Icons.messenger_outline,
                                      //   color: Color(0xff5956E9),
                                      // ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        filled: true,
                                        fillColor:Colors.white ,
                                        contentPadding: EdgeInsets.only(left: 10),
                                        hintText: "Price",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color.fromRGBO( 229, 229, 229, 1), width: 2),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color.fromRGBO( 229, 229, 229, 1), width: 1.5),
                                            borderRadius:  BorderRadius.circular(10)
                                        ),
                                        hintStyle:
                                        GoogleFonts.raleway(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400
                                        )),
                                  ),
                                  SizedBox(height: 20,),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 50.0,right: 50,bottom: 20),
                                    child: GestureDetector(
                                      onTap: () async {
                                        final results = await FilePicker.platform.pickFiles(
                                          allowMultiple: false,
                                          type: FileType.custom,
                                          allowedExtensions: ['png','jpg'],
                                        );
                                        if(results ==null){
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('No file selected'),
                                            ),
                                          );
                                          return null;
                                        }
                                        final path = results.files.single.path!;
                                        final fileName = results.files.single.name ;

                                        imagePath=path;
                                        setState(() {

                                        });
                                        print(path);
                                        print(fileName);
                                      },
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0xff5956E9),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text('Upload Image',
                                              style: GoogleFonts.raleway(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: (){
                                      if (_key.currentState!.validate()){
                                        sendUserName();
                                      }

                                    },
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xff5956E9),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text('Post laptop',
                                            style: GoogleFonts.raleway(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                        onPressed: (){
                        setState(() {
                          currentScreen = Home();
                          curretTab=0;
                        });
                        },
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home_filled,
                            color:curretTab==0 ? 
                            Color(0xff5956E9):Colors.grey,),
                        ], 
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: (){
                        setState(() {
                          currentScreen = Favourite();
                          curretTab=1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite_outline,
                            color:curretTab==1 ?
                            Color(0xff5956E9):Colors.grey,),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: (){
                        setState(() {
                          currentScreen = Cart();
                          curretTab=2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined,
                            color:curretTab==2 ?
                            Color(0xff5956E9):Colors.grey,),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: (){
                        setState(() {
                          currentScreen =Profile();
                          curretTab=3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_outline,
                            color:curretTab==3 ?
                            Color(0xff5956E9):Colors.grey,),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
       ),
    );
  }


  File? image;
  Future pickImage() async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png','jpg'],
    );
    if(results ==null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected'),
        ),
      );
      return null;
    }
    final path = results.files.single.path!;
    final fileName = results.files.single.name ;
    print(path);
    print(fileName);
  }
  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = Path.basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  UploadTask? uploadTask;
  Future uploadImage() async{
    final path = 'files/${image!.path}';
    final file = File(image!.path);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
      this.notLoading = false;
    });
    final snapshot = await uploadTask!.whenComplete((){});
    final String urlDownload = await snapshot.ref.getDownloadURL();
    final String name = _name.text;
    final String desc = _desc.text;
    final double? price = double.tryParse(_price.text);

    if (price != null ){
      await _collectionRef.add({'name':name, 'desc':desc, "price": price, 'image':urlDownload});
      _name.text = '';
      _desc.text = '';
      _price.text = '';
      Navigator.pop(context);
    }
    print('Download Link: $urlDownload');
    setState(() {
      uploadTask = null;
      this.notLoading = true;
    });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {

      _name.text = documentSnapshot['name'];
      _desc.text = documentSnapshot['description'];
      _price.text = documentSnapshot['price'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _desc,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _price,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text( 'Update'),
                  onPressed: () async {
                    final String name = _name.text;
                    final String desc = _desc.text;
                    final double? price =
                    double.tryParse(_price.text);
                    if (price != null) {

                      await _collectionRef
                          .doc(documentSnapshot!.id)
                          .update({"name": name, "price": price,"description":desc});
                      _name.text = '';
                      _desc.text = '';
                      _price.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _collectionRef.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }
}

