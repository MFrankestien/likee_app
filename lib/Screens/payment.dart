import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'RoutePage.dart';
import '../Widget/app_bar.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class MasterCard extends StatefulWidget {
  @override
  _MasterCardState createState() => _MasterCardState();
}
class _MasterCardState extends State<MasterCard>
    with SingleTickerProviderStateMixin {
  String cardnumber='', name='', expiredate='', cvv='';
  bool ismaster=true;
  TextEditingController cardnumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  var numberFormatter = new MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );
  var dateFormatter = new MaskTextInputFormatter(
    mask: '##/##',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final _focusNode = FocusNode();
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'ONE';

  // Group Value for Radio Button.
  int id = 1;
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      cardKey.currentState!.toggleCard();
    });
  }
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, isTransparent: true, title: ''),
      body: Column(children: [
        Text("Payment Details",style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),),
        SizedBox(height: 30),
        FlipCard(
          direction: FlipDirection.HORIZONTAL,
          key: cardKey,
          front: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Container(
              height: 200,
              width: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.black),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Credit & Debit Card",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Icon(
                          Icons.credit_card,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Row(
                      children: [
                        Text(
                          (cardnumber != null && cardnumber != "")
                              ? cardnumber
                              : "xxxx xxxx xxxx xxxx",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Text(
                          (expiredate != null && expiredate != "")
                              ? expiredate
                              : "MM/YY",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (name != null && name != "") ? name : "card holder:",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Image.asset(
                          "assets/mastercard.png",
                          height: 27,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          back: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: 200,
              width: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.grey),
              child: Column(children: [
                SizedBox(
                  height: 25,
                ),
                Container(height: 50, width: 350, color: Colors.black),
                SizedBox(
                  height: 50,
                ),
                Row(children: [
                  Container(height: 25, width: 200, color: Colors.white),
                  SizedBox(width: 55),
                  Container(
                      height: 25,
                      width: 60,
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          (cvv != null && cvv != "") ? cvv : "XXX",
                        ),
                      )),
                ])
              ]),
            ),
          ),
        ),
        SizedBox(height: 30),
        Expanded(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text("How would you like to pay ?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'Visa';
                              id = 1;
                              ismaster=true;
                            });
                          },
                        ),
                        Text(
                          'Visa',
                          style: new TextStyle(fontSize: 17.0),
                        ),

                        Radio(
                          value: 2,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'MasterCard';
                              id = 2;
                              ismaster=true;
                            });
                          },
                        ),
                        Text(
                          'MasterCard',
                          style: new TextStyle(
                            fontSize: 17.0,
                          ),
                        ),

                        Radio(
                          value: 3,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'PayPal';
                              id = 3;
                              ismaster=true;
                            });
                          },
                        ),
                        Text(
                          'PayPal',
                          style: new TextStyle(fontSize: 17.0),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          value: 4,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'Fawry';
                              id = 4;
                              ismaster=false;
                            });
                          },
                        ),
                        Text(
                          'Fawry',
                          style: new TextStyle(fontSize: 17.0),
                        ),

                        Radio(
                          value: 5,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'Vodafone Cash';
                              id = 5;
                              ismaster=false;
                            });
                          },
                        ),
                        Text(
                          'Vodafone Cash',
                          style: new TextStyle(
                            fontSize: 17.0,
                          ),
                        ),


                      ],
                    ),
                  ),
                  ismaster?_Cards():TextField(
                    inputFormatters: [dateFormatter],
                    controller: dateController,
                    onChanged: (date) {
                      setState(() {
                        expiredate = date;
                      });
                    },
                    maxLength: 5,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Serial Number ",
                        hintText: "XX/XX",
                        counterText: "",
                        suffixIcon:
                        Icon(Icons.confirmation_num, color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RoutePage()),
          );
        },
        label: Text('Confirm'),
        icon: Icon(Icons.payment_rounded),
        backgroundColor: Colors.pink,
      ) ,
    );
  }
  Widget _Cards() {
    return Column(
      children: [ Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: TextField(
              inputFormatters: [numberFormatter],
              controller: cardnumberController,
              onChanged: (number) {
                setState(() {
                  cardnumber = number;
                });
              },
              keyboardType: TextInputType.number,
              maxLength: 19,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Number",
                  hintText: "XXXX XXXX XXXX XXXX ",
                  counterText: "",
                  isDense: true,
                  suffixIcon: Icon(
                    Icons.credit_card,
                    color: Colors.black,
                  )))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(children: [
            Expanded(
              flex: 1,
              child: TextField(
                inputFormatters: [dateFormatter],
                controller: dateController,
                onChanged: (date) {
                  setState(() {
                    expiredate = date;
                  });
                },
                maxLength: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "ExpireyDate",
                    hintText: "XX/XX",
                    counterText: "",
                    suffixIcon:
                    Icon(Icons.date_range, color: Colors.black)),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: TextField(
                controller: nameController,
                onChanged: (cardname) {
                  setState(() {
                    name = cardname;
                  });
                },
                // maxLength: 20,
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(25),
                  FilteringTextInputFormatter.allow(
                      RegExp('[a-zA-Z]')),
                ],
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Card Holder",
                    counterText: "",
                    suffixIcon:
                    Icon(Icons.person, color: Colors.black)),
              ),
            )
          ]),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Row(children: [
            Expanded(
              flex: 1,
              child: TextField(
                controller: cvvController,
                onChanged: (number) {
                  setState(() {
                    cvv = number;
                  });
                },
                focusNode: _focusNode,
                maxLength: 3,
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "CVV",
                    hintText: "XXX",
                    counterText: "",
                    suffixIcon:
                    Icon(Icons.date_range, color: Colors.black)),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Postal Code",
                    counterText: "",
                    suffixIcon: Icon(Icons.location_on_outlined,
                        color: Colors.black)),
              ),
            )
          ]),
        ),],
    );
  }
}