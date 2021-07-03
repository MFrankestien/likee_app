import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:likee_app/Drawer.dart';
import 'package:likee_app/info.dart';
import 'package:likee_app/models/firestore.dart';

import 'Widget/bezierContainer.dart';
import 'app_bar.dart';

class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  String? username, followers = " ", following, bio, website, profileimage;
  final FirebaseAuth auth = FirebaseAuth.instance;
  FlutterInsta flutterInsta = FlutterInsta(); // create instance of FlutterInsta class
  TextEditingController usernameController = TextEditingController();
  TextEditingController reelController = TextEditingController();
  bool show =true;
  final _instafun = instaModel(insta: '');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(instaModel instamodel) => ListTile(
      isThreeLine: true,
      title: Text(
        instamodel.insta,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Click Follow to Get 1  Coin',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8 ,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
              GestureDetector(
              onTap: () {},
      child: Container(
        width: 160,
        height: 30,
        child: Center(child:Text("Follow",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:  [Color(0xff1a84b8), Color(0xff2b6ff7)]
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(5, 5),
              blurRadius: 6,
            )
          ],
        ),)
              )],
              ),

            ],
          ),
        ],
      ),
      trailing:Image(
          width: 60.0,
          height: 60.0,
          image:NetworkImage("https://play-lh.googleusercontent.com/7hAq25yPmjdVuPeEpC8DQnHGsgo-BuNXhRVlSt0IYOXpKj8puu0PCDFsZHlJWkdN8kU")
      ),

      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InfoPage(instamodel:instamodel)));
print(instamodel.insta);
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
    final height = MediaQuery.of(context).size.height;
      return Scaffold(
        appBar: buildAppBar(context,isTransparent: true,title: ''),
        extendBodyBehindAppBar: true,
        drawer:Drawer(
          child:  MainDrawer()  ,
        ),
        body: SingleChildScrollView(
          child: Stack(
          children: [
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),

            Column(
              children: [

                SizedBox(height: 200,),
                StreamBuilder<QuerySnapshot>(
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
                    }),],
            )],
        ),),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RoutePage()),
            );
          },
          label:  Text('300',style: TextStyle(color: Colors.black),),
          icon: Icon(Icons.monetization_on_outlined,color:Colors.black ,size:40,),
          backgroundColor: Colors.yellow,
            ),
    );

    }
  Future printDetails(String username) async {
    await flutterInsta.getProfileData(username);
    setState(() {
      this.username = flutterInsta.username; //username
      this.followers = flutterInsta.followers; //number of followers
      this.following = flutterInsta.following; // number of following
      this.website = flutterInsta.website; // bio link
      this.bio = flutterInsta.bio; // Bio
      this.profileimage = flutterInsta.imgurl; // Profile picture URL
      print(followers);
    });
  }
    }


