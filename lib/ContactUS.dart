import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:likee_app/RoutePage.dart';
import 'package:likee_app/signup.dart';

import 'Widget/bezierContainer.dart';

class ContactUS extends StatefulWidget {
  ContactUS({Key ?key}) : super(key: key);


  @override
  _ContactUSState createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  String email = '';
  String password = '';
  String error = '';
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Widget _submitButton() {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          try{
            dynamic result =
            await auth.signInWithEmailAndPassword(email: email.trim(), password: password.toLowerCase());
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => RoutePage()));
          }catch(e){
            print(e);
            if (e!=null){
              setState(() {
                error =
                'Could not sign in with those credentials wrong Email or Password';
              });
            }
          }


        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff1a84b8), Color(0xff2b6ff7)])),
        child: Text(
          '',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[



          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'LIK',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xfffc7b22),
          ),
          children: [
            TextSpan(
              text: 'EE',
              style: TextStyle(color: Color(0xff2b6ff7), fontSize: 30),
            ),

          ]),
    );
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(height: 50),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height:20 ,),
                                    Text(
                                      "Send Us Email on",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                                    ),
                                    SizedBox(height:30 ,),
                                    Text(

                                      "Likee-Support@gmail.com",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                                    ),
                                    SizedBox(height:30 ,),
                                    Text(
                                      "Likee-Yahoo@gmail.com",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),

                                    ),
                                    SizedBox(height:30
                                      ,),

                                    Text(
                                      "Phone: 19888",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),

                                    ),

                                  ],
                                ),
                              ),

                            ],
                          )),



                      SizedBox(height: height * .055),
                      _createAccountLabel(),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
