import 'package:fireapp/about_us/test.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'about_us/faqupdate.dart';
import 'home/home.dart';
import 'about_us/about_us.dart';
import 'favorée/Favorable.dart';
import 'home/profil2.dart';
import 'login/first_page.dart';
import 'login/login.dart';
import 'login/signup.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    color: Color(0xff5097a4),
    home:login(),
  ));
}

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  Widget cont = SpecialitiesList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: cont,
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        height: 50,
        buttonBackgroundColor: Color(0xff5097a4),
        backgroundColor: Colors.white,
        color: Colors.blueGrey.shade50,
        items: <Widget>[
          Icon(Icons.favorite_border),
          Icon(
            Icons.home,
          ),
          Icon(Icons.contact_phone)
        ],
        onTap: (index) {
          setState(() {
            if (index == 0) {
              cont = Favorable();
            }
            if (index == 1) {
              cont = SpecialitiesList();
            }
            if (index == 2) {
              cont = about_us();
            }
          });
        },
      ),
    );
  }
}
