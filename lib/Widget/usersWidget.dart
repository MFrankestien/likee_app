import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:likee_app/models/firestore.dart';

class InstaWid extends StatefulWidget {
  @override
  _InstaWidState createState() => _InstaWidState();
}

class _InstaWidState extends State<InstaWid> {

  bool show =true;
  final _instafun = instaModel(insta: '');

  @override
  void initState() {
    super.initState();

  }

  Widget build(BuildContext context) {
    ListTile makeListTile(instaModel instamodel) => ListTile(
      isThreeLine: true,
      title: Text(
        instamodel.insta,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        instamodel.insta,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      trailing:Image(
          width: 60.0,
          height: 60.0,
          image:NetworkImage("https://i.stack.imgur.com/l60Hf.png")
      ),

      onTap: () {

      },
    );

    Card makeCard(instaModel instamodel) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: makeListTile(instamodel),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body:  StreamBuilder<QuerySnapshot>(
          stream: _instafun.loaduser(),
          builder: (context,snapshot) {
            if (snapshot.hasData) {
              List users = [];

              for (var doc in snapshot.data!.docs) {
                Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

                users.add(instaModel(
                  insta: data!['instauser'],
                ));
                print(users);
              }
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return makeCard(users[index]);

                },
              );
            }
            else {
              return Center(child: Text('loading ..'));
            }
          }),
    );
  }
}