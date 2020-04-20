import 'package:flutter/material.dart';
import 'package:fireapp/home/home.dart';
import 'package:fireapp/login/second_page.dart';
import 'package:fireapp/main.dart';

class ConfirmationCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConfirmationCode();
  }
}

class _ConfirmationCode extends State<ConfirmationCode> {
  final TextEditingController _username = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 60.0, left: 30.0, bottom: 290, right: 30),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(10.0, 15.0),
                          blurRadius: 15.0),
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(-10.0, -10.0),
                          blurRadius: 10.0),
                    ],
                    border: Border.all(
                        color: Color(0x8F17ead9),
                        width: 10.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(200.0)),
                child: Center(
                  child: Image.asset(
                    "images/image_2.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 25, left: 20, right: 20),
              child: Container(
                color: Colors.white30,
                child: ListView(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Route route = MaterialPageRoute(builder: (context)=>Phone_Email());
                              Navigator.push(context, route);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black87,
                              size: 30,
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 170,
                    ),
                    Container(
                      width: double.infinity,
                      height: 290,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(10.0, 15.0),
                                blurRadius: 15.0),
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, -10.0),
                                blurRadius: 10.0),
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 25,
                          right: 15,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "We sent a 6-digit code to your mobile number / Email . Enter that code to end the registration ",
                                style: TextStyle(
                                  color: Colors.blueGrey.shade700,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            TextField(
                              keyboardType:TextInputType.number ,
                              controller: _username,
                              decoration: InputDecoration(
                                  hintText: "Enter the Code	",
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  icon: Icon(Icons.contact_mail),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.green))),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 48,
                                  width: 140,
                                  child: GestureDetector(
                                    onTap: () {
                                      Route route = MaterialPageRoute(builder: (context)=>Myapp());
                                      Navigator.push(context, route);
                                    }, //go to home (specialities page)
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF17ead9),
                                            Color(0xFF6078ea),
                                          ], tileMode: TileMode.clamp),
                                          borderRadius:
                                          BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xFF6078ea)
                                                    .withOpacity(.3),
                                                offset: Offset(0.0, 8.0),
                                                blurRadius: 8.0),
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                            child: Text("Continue",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Poppins-Bold",
                                                    fontSize: 16,
                                                    letterSpacing: 1.0)),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Center(
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.black,
                                              size: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Didn't get the Code ?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {},//send code to phone / email again
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Send Code again ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
    ;
  }
}