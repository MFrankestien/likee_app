import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:likee_app/loginPage.dart';
import 'package:likee_app/services/auth.dart';

import 'Widget/bezierContainer.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);



  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _formKey = GlobalKey<FormState>();
  String remail='';
  String rpassword='';
  String repassword='';
  String error = '';
  String insta='';
  final AuthService auth = AuthService(uid: '');

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          print(remail);
          print(insta);
          print(rpassword);
          print(repassword);

          dynamic result = await auth.registerWithEmailAndPassword(
              remail.trim(), rpassword.toLowerCase());
          if (result == null) {
            setState(() {
              error = 'Please supply a valid email';
            });
          } else {
            await AuthService(uid: result.uid)
                .updateUserData( insta, remail);
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
            'Login',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
    );
    }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'd',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ev',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'rnz',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
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
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(
                        height: 50,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Email",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                      validator: (val) =>
                                      val!.isEmpty ? 'Enter an email' : null,
                                      onChanged: (val) {
                                        setState(() => remail = val);
                                      },
                                      obscureText: false,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Color(0xfff3f3f4),
                                          filled: true))
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Password",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                      validator: (val) => val!.length < 6
                                          ? 'Enter a password 6+ chars long'
                                          : null,
                                      onChanged: (val) {
                                        setState(() => rpassword = val);
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Color(0xfff3f3f4),
                                          filled: true))
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Confirm password",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                      validator: (val) =>
                                      val != rpassword ? 'not match' : null,
                                      onChanged: (val) {
                                        setState(() => repassword = val);
                                      },
                                      obscureText: false,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Color(0xfff3f3f4),
                                          filled: true))
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Instagram User",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                      initialValue: "@",
                                      validator: (val) =>
                                      val!.isEmpty ? 'Enter youer instagram user' : null,
                                      onChanged: (val) {
                                        setState(() => insta = val);
                                      },
                                      obscureText: false,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Color(0xfff3f3f4),
                                          filled: true))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _submitButton(),
                      SizedBox(height: height * .14),
                      _loginAccountLabel(),
                    ],
                  )],
                ),
                ),
              ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
