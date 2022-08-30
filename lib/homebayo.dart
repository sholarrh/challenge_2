
import 'dart:io';

import 'package:buylap/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference _reference =  FirebaseFirestore.instance.collection('users-data');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Text('Order online\ncollect in store',
                    style: GoogleFonts.raleway(
                        color: Colors.black,
                        fontSize: 34,
                        fontWeight: FontWeight.w700
                    )),
                SizedBox(height: 20,),
                StreamBuilder(
                  stream: _reference.snapshots().asBroadcastStream(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                    if(snapshot.hasError){
                      return Center(child: Text('error'));
                    }else{
                      if(!snapshot.hasData){
                        Center(child:
                        CircularProgressIndicator(color: Colors.red,));
                      }else{
                        final datavalue =
                            snapshot.data!.docs.toList();
                        print(datavalue.length);
                        print(datavalue[0].data());
                        return Container(
                          height: 800,
                          child: ListView.builder(
                            itemCount: datavalue.length,
                              itemBuilder: (context,index){
                              return  SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      // onTap: (){
                                      //   Navigator.push(context,
                                      //   MaterialPageRoute(builder: (context)=>View()));
                                      // },
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 20.0),
                                        child: Container(
                                          height: 130,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20.0,top: 10),
                                                child: Container(
                                                    height:100,
                                                    width: 100,
                                                    child:
                                                    Image.file(File('${datavalue[0]['imagepath'].toString()}'))

                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 20,),
                                                    Text('${datavalue[index]['name']} \n ${datavalue[index]['description']}'
                                                        ,
                                                        style: GoogleFonts.raleway(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600
                                                        )),
                                                    SizedBox(height: 20,),
                                                    Row(
                                                      children: [
                                                        Text('₦',
                                                            style: GoogleFonts.raleway(
                                                                color: Color(0xff5956E9),
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w700
                                                            )),
                                                        Text('${datavalue[index]['price']}',
                                                            style: GoogleFonts.raleway(
                                                                color: Color(0xff5956E9),
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w700
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              }
                          ),
                        );
                      }
                      return SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
