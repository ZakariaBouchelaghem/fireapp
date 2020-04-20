import 'package:flutter/material.dart';
import 'package:fireapp/home/home.dart';
import 'package:fireapp/login/second_page.dart';
import 'package:fireapp/login/social_card.dart';
import 'package:fireapp/main.dart';

class MyLogin extends StatelessWidget {
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
              padding: EdgeInsets.only(top: 70.0, left: 30.0,bottom: 290,right: 30),
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
            ),),
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 30, left: 20,right: 20),
              child: Container(
                color: Colors.white30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          "images/logo.png",
                          width: 55,
                          height: 55,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Welcome to Doc it",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 25,
                                letterSpacing: .6,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(
                      height: 200,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                          "Click Skip if you want to register with Phone number/email",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 18,
                              //   letterSpacing: .6,
                              fontWeight: FontWeight.bold)
                      ),
                    ),
                    SizedBox(height: 15,),
                    Register(
                      colors: [
                        Color(0xFF00eaf8),
                        Color(0xFF187adf),
                      ],
                      text: "Register with facebook",
                      photo: ImageIcon(
                        AssetImage(
                          "images/facebook.png",
                        ),
                        color: Colors.white,
                        size: 38,
                      ),
                      onPressed: () {
                        Route route = MaterialPageRoute(builder: (context)=>Myapp());
                        Navigator.push(context, route);
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Register(
                      colors: [
                        Color(0xFFff4f38),
                        Color(0xFF5f355d),
                      ],
                      text: "Register with google",
                      photo: ImageIcon(
                        AssetImage(
                          "images/google.png",
                        ),
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Route route = MaterialPageRoute(builder: (context)=>Myapp());
                        Navigator.push(context, route);
                      },
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: (){
                        Route route = MaterialPageRoute(builder: (context)=>Phone_Email());
                        Navigator.push(context, route);
                      },//go to second page
                      child : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Skip " ,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins-Medium",
                              fontSize:22,
                            ),),
                          Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                          SizedBox(width: 20,),
                        ],
                      ),),

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