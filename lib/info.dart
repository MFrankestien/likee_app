import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:likee_app/body.dart';
import 'package:likee_app/models/firestore.dart';

import 'main.dart';

class InfoPage extends StatefulWidget {
    final instaModel instamodel;
    InfoPage({required this.instamodel});
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool isSearching = false;
  String userName='';

  @override
  void initState() {
    setState(() {
      userName=widget.instamodel.insta;
      print('userName $userName');
      print(widget.instamodel.insta);
    });
    getHttp(userName, context);

  }



  void getHttp(String userName, BuildContext context) async {
    isVisibleAllElement = false;
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      print("not connected ");

      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Check Your Network Connection!!!')));
    } else {
      print("I am connected to a network.");

      try {
        Response response =
            await Dio().get("https://www.instagram.com/$userName/?__a=1");

        print(response.statusCode);
        String statusCode = response.statusCode.toString();

        if (statusCode == "200") {
          setState(() {
            print('s');
            isVisibleAllElement = true;


            String _posts = response.data["graphql"]["user"]
                    ["edge_owner_to_timeline_media"]["count"]
                .toString();
            String _followers = response.data["graphql"]["user"]
                    ["edge_followed_by"]["count"]
                .toString();
            String _following = response.data["graphql"]["user"]["edge_follow"]
                    ["count"]
                .toString();
            bool _isPrivate = response.data["graphql"]["user"]["is_private"];
            bool _isVerified = response.data["graphql"]["user"]["is_verified"];
            String _fullName =
                response.data["graphql"]["user"]["full_name"].toString();
            String _biography =
                response.data["graphql"]["user"]["biography"].toString();
            String _externalUrl =
                response.data["graphql"]["user"]["external_url"].toString();

            print(response.statusMessage);
            print(_biography);
            print(_externalUrl);
            print(_followers);
            print(_following);
            print(_fullName);
            print(_isPrivate);
            print(_isVerified);
            print(_posts);

            dpUrl = response.data["graphql"]["user"]["profile_pic_url_hd"];
            posts = _posts;
            followers = _followers;
            following = _following;
            isPrivate = _isPrivate;
            isVerified = _isVerified;
            fullName = _fullName;
            biography = _biography;
            externalUrl = _externalUrl;
            setState(() {
              isSearching=false;
            });
          });
        }
      } catch (e) {
        print(e);
        // print("======================================================");

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("TopBar");
    return Scaffold(
      body: isSearching == true
          ? Center(child: CircularProgressIndicator())
          : Body(),
      appBar: AppBar(
        title: Text(userName),
        actions: [

        ],
      ),
    );
  }
}
