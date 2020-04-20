import 'package:flutter/material.dart';
import 'package:fireapp/login/third_page.dart';
import 'first_page.dart';

class Phone_Email extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Phone_EmailState();
  }
}

class _Phone_EmailState extends State<Phone_Email> {
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
                            onTap: () {
                              Route route = MaterialPageRoute(
                                  builder: (context) => MyLogin());
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
                      height: 160,
                    ),
                    Container(
                      width: double.infinity,
                      height: 220,
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
                          children: <Widget>[
                            Padding(
                              padding:
                              EdgeInsets.only(top: 10, left: 20, right: 20),
                              child: Text(
                                "Enter your phone number or your email",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.blueGrey.shade700,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextField(
                              controller: _username,
                              decoration: InputDecoration(
                                  hintText: "Phone or Email	",
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  icon: Icon(Icons.account_circle),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.green))),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  height: 48,
                                  width: 140,
                                  child: GestureDetector(
                                    onTap: () {
                                      Route route = MaterialPageRoute(
                                          builder: (context) =>
                                              ConfirmationCode());
                                      Navigator.push(context, route);
                                    }, //go to third page
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
                            )
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
  }
}