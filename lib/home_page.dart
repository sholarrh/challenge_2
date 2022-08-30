import 'package:challenge_2/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Users');

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage(
                          'assets/images/OOPL-Cinemas-logo-white-website-logo-web.png')),
                ),
                SizedBox(
                  width: 25,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Movie Search',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Go',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  child: PopupMenuButton(
                      itemBuilder: (context) => [
                            PopupMenuItem(
                                child: Row(
                              children: [
                                Icon(Icons.account_circle_outlined),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('USER')
                              ],
                            )),
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => movie()));
                                    },
                                    child: Text('Add New Movie'))),
                            PopupMenuItem(
                              child: ElevatedButton(
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onPressed: () {
                                  FirebaseAuth.instance.signOut().then((value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  });
                                },
                              ),
                            )
                          ]),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black26,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.blueAccent,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Row(
              //         children: [
              //           Container(
              //             height: 50,
              //             width: 50,
              //             child: Image(
              //                 fit: BoxFit.contain,
              //                 image: AssetImage(
              //                     'assets/images/OOPL-Cinemas-logo-white-website-logo-web.png')),
              //           ),
              //           SizedBox(
              //             width: 25,
              //           ),
              //           Container(
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(30),
              //               color: Colors.white,
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Text(
              //                 'Movie Search',
              //                 textAlign: TextAlign.left,
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.w400,
              //                   fontSize: 16,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //             ),
              //           ),
              //           SizedBox(
              //             width: 5,
              //           ),
              //           Container(
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(30),
              //               color: Colors.white,
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.all(4.0),
              //               child: Text(
              //                 'Go',
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.w400,
              //                   fontSize: 16,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           InkWell(
              //             child: PopupMenuButton(
              //                 itemBuilder: (context) => [
              //                       PopupMenuItem(
              //                           child: Row(
              //                         children: [
              //                           Icon(Icons.account_circle_outlined),
              //                           SizedBox(
              //                             width: 5,
              //                           ),
              //                           Text('USER')
              //                         ],
              //                       )),
              //                       PopupMenuItem(child: Text('Add New Movie')),
              //                       PopupMenuItem(
              //                         child: ElevatedButton(
              //                           child: Text(
              //                             'Logout',
              //                             style: TextStyle(
              //                               color: Colors.red,
              //                               fontSize: 20,
              //                               fontWeight: FontWeight.w400,
              //                             ),
              //                           ),
              //                           onPressed: () {
              //                             FirebaseAuth.instance
              //                                 .signOut()
              //                                 .then((value) {
              //                               Navigator.push(
              //                                   context,
              //                                   MaterialPageRoute(
              //                                       builder: (context) =>
              //                                           LoginPage()));
              //                             });
              //                           },
              //                         ),
              //                       )
              //                     ]),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 40,
              // ),
              // ElevatedButton(
              //   child: Text(
              //     'Logout',
              //     style: TextStyle(
              //       color: Colors.red,
              //       fontSize: 20,
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              //   onPressed: () {
              //     FirebaseAuth.instance.signOut().then((value) {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => LoginPage()));
              //     });
              //   },
              // ),
              StreamBuilder(
                stream: _reference.snapshots().asBroadcastStream(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('error'));
                  } else {
                    if (!snapshot.hasData) {
                      Center(
                          child: CircularProgressIndicator(
                        color: Colors.red,
                      ));
                    } else {
                      final datavalue = snapshot.data!.docs.toList();
                      print(datavalue.length);
                      print(datavalue[0].data());
                      return Container(
                          height: 800,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(2),
                            itemCount: preview.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Slidable(
                                // startActionPane: ActionPane(
                                //   motion: ScrollMotion(),
                                //   children: [
                                //     SlidableAction(onPressed: (_){},
                                //     icon: Icons.menu,
                                //     backgroundColor: Colors.blueAccent,)
                                //   ],
                                // ),
                                endActionPane: ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) {},
                                      icon: Icons.menu,
                                      backgroundColor: Colors.blueAccent,
                                    ),
                                    SlidableAction(
                                      onPressed: (_) {},
                                      icon: Icons.delete_outline,
                                      backgroundColor: Colors.red,
                                    )
                                  ],
                                ),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 130,
                                          height: 130,
                                          child: Image.file(File(
                                              '${datavalue[0]['imagepath'].toString()}'))),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${title[index]}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 10,
                                          // ),
                                          // Icon(
                                          //   Icons.edit,
                                          //   color: Colors.white,
                                          // ),
                                          // Icon(
                                          //   Icons.delete_outline,
                                          //   color: Colors.white,
                                          // )
                                          // Text('${description[index]}'),
                                          // // Text('$description'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ));
                    }
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Stream<List<User>> readUsers() => FirebaseFirestore.instance
//     .collection('Users')
//     .snapshots()
//     .map((snapshot) => snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
// //

List<String> preview = <String>[
  'assets/images/beast.jpg',
  'assets/images/bullet-train.jpg',
  'assets/images/dragonball.jpg',
  'assets/images/hammer.jpg',
  'assets/images/hey-you.jpg',
  'assets/images/obaram.jpg',
  'assets/images/rubicon.jpg',
  'assets/images/setup2.jpg',
  'assets/images/the-invitation.jpg',
  'assets/images/the-stranger-i-know.jpg',
  'assets/images/thor.jpg'
];

List<String> title = <String>[
  'Beast',
  'Bullet Train',
  'Dragonball',
  'Hammer',
  'Hey You',
  'Obaram',
  'Rubicon',
  'Setup 2',
  'The Invitation',
  'The Stranger I Know',
  'Thor \n Love and Thunder'
];

List<String> description = <String>[
  'Recently widowed Dr. Nate Daniels and his two teenage daughters travel to a South African game reserve managed by '
      'Martin Battles, an old family friend and wildlife biologist. However, what begins as a journey of healing '
      'soon turns into a fearsome fight for survival when a lion, a survivor of bloodthirsty poachers, begins stalking them',
  'The life of an awkward 32 years old software engineer is turned upside down when he finds out the girl he wants to be with is the FANSALONE model he obsesses over and she’s his next-door neighbour.',
  'A veteran  broadcaster is at a crossroad, either to accept to campaign for a corrupt politician and make a fortune or to maintain his integrity and forfeit his  most valuable profession.'
];
