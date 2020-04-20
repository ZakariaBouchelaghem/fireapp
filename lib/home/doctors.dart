import 'package:fireapp/databasehelper.dart';
import 'package:fireapp/home/profil2.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:simple_animations/simple_animations.dart';


class DoctorsList extends StatefulWidget {
  String nom;
  DoctorsList({Key key, @required this.nom}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DoctorsListState(name:nom);
  }
}

class _DoctorsListState extends State<DoctorsList> with SingleTickerProviderStateMixin{

   String name;

  final TextStyle dropdownMenuItem =
  TextStyle(color: Colors.blueGrey, fontSize: 18);

  final primary = Color(0xff5097a4); //0xff696b9e
  final secondary = Color(0xfff29a94);

//  String specialitieName;
//  List<Doctor> data;

  final TextEditingController _searchDoctor = new TextEditingController();
  String _searchText = "";
  var db = DatabaseHelper();


  //Monitor the instant change in the search text
  _DoctorsListState({Key key, this.name}) {
    _searchDoctor.addListener(() {
      if (_searchDoctor.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _searchDoctor.text;
        });
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Stack(
            children: <Widget>[
              //build a list of doctors
              Container(
                padding: EdgeInsets.only(top: 145),
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: double.infinity,
                child: StreamBuilder(
                  stream: Firestore.instance.collection(name).snapshots(),
                  builder: (context, snapshot) {
                    switch(snapshot.connectionState){
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator(backgroundColor: Color(0xff5097a4),));
                      default:
                        return ListView(
                          children: (_searchText ==null || _searchText.toString() =="")?makelist(snapshot): makelist3(snapshot),
                        );
                    }
                  },
                ),
              ),
              //build the shape of appBar

              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        // go to Specialitie page
                        onPressed: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => SpecialitiesList());
                          Navigator.pop(context, route);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "specialité",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Raleway'),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                ),
              ),

              //build the decoration of search card
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 110,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: TextField(
                          controller: _searchDoctor,
                          cursorColor: Theme
                              .of(context)
                              .primaryColor,
                          style: dropdownMenuItem,
                          decoration: InputDecoration(
                              hintText: "Search a Doctor ",
                              hintStyle: TextStyle(
                                  color: Colors.black38, fontSize: 16),
                              prefixIcon: Material(
                                elevation: 0.0,
                                borderRadius:
                                BorderRadius.all(Radius.circular(30)),
                                child: Icon(Icons.search),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 13)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, var document) {
    return FutureBuilder(
      future: db.getUser(document['nom']),
      builder: (context , snapshot){
        return GestureDetector(
          onTap: ()   {

            Navigator.push(context, MaterialPageRoute(builder: (context)  {
              return profil(info: document,docEx :snapshot.hasData );
            }));
          }, // go to the doctors profile
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white70,
            ),
            width: double.infinity,
            height: 140,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //photo of doctor
                Container(
                  width: 80,
                  height: 80,
                  margin: EdgeInsets.only(right: 10, top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 3, color: secondary),
                    image: DecorationImage(
                        image: NetworkImage(document["profilimage"]), fit: BoxFit.cover),
                  ),
                ),
                //doctor information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        document["nom"],
                        style: TextStyle(
                            color: Color(0xff696b9e),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.school,
                            color: secondary,
                            size: 22,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(document["grad"],
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  color: Color(0xff696b9e),
                                  fontSize: 14,
                                  letterSpacing: .3)),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: secondary,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(document["exper"],
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  color: Color(0xff696b9e),
                                  fontSize: 14,
                                  letterSpacing: .3)),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: secondary,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(document["wilaya"],
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  color: Color(0xff696b9e),
                                  fontSize: 14,
                                  letterSpacing: .3)),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.add_location,
                            color: secondary,
                            size: 20,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(document["location"],
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  color: Color(0xff696b9e),
                                  fontSize: 14,
                                  letterSpacing: .3)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> makelist(AsyncSnapshot snapshot) {
    return snapshot.data.documents.map<Widget>((document) {
      return buildCard(context, document);
    }).toList();
  }
  List<Widget> makelist2(AsyncSnapshot snapshot) {
    return snapshot.data.documents.map<Widget>((document) {
      if(document['nom'].toString().toLowerCase().contains(_searchText.toString())|| document['nom'].toUpperCase().toString().contains(_searchText.toString())
          || document['nom'].toString().contains(_searchText.toString()))   {return buildCard(context, document);}
    }).toList();
  }
  List<Widget> makelist3(AsyncSnapshot snapshot) {
    List<Widget> list = [];
    for(int i=0 ; i<makelist2(snapshot).length;i++){
      if(makelist2(snapshot).elementAt(i)!= null){list.add(makelist2(snapshot).elementAt(i));}
    }
    return list.toList();
  }


}
//_searchText == null || _searchText == ""
//? buildCard(context, index)
//: data[index].name.toLowerCase().contains(_searchText.toLowerCase()) ||
//data[index].wilaya.toLowerCase().contains(_searchText.toLowerCase())
//? buildCard(context, index)
//: Container()
