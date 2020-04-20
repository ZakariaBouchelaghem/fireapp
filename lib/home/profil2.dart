import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireapp/databasehelper.dart';
import 'package:fireapp/home/map.dart';
import 'package:fireapp/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'doctors.dart';
import 'package:provider/provider.dart';




class profil extends StatefulWidget {
  var db =  DatabaseHelper();
  var info;
  var docEx;
  profil({this.info,this.docEx});
  @override
  _profilState createState() => _profilState(info,docEx:docEx);
}

class _profilState extends State<profil>   with SingleTickerProviderStateMixin {
  AnimationController _controller2;
  Animation _animation;
  @override
  void initState() {
    super.initState();
    _controller2 =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end:pi).animate(_controller2)
    ..addListener(
        (){
          setState(() {

          });
        }
    );
    _controller2.forward();
  }
  bool a;
  Completer<GoogleMapController> _controller = Completer();
  var info;
  var docEx;
  bool  b;
  _profilState(this.info,{this.docEx});
  var db = DatabaseHelper();
  Icon _icon;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){call("tel:${info["number"]}");},child: Icon(Icons.call,color: Color(0xfff29a94),),backgroundColor: Colors.white,),
        body: Container(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipPath(

                    clipper: WaveClipperTwo(),
                    child: Container(
                      height: MediaQuery.of(context).size.height/4-20,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.3,1],
                            colors: [Color(0xff5097a4),Color(0xfff29a94)]
                        ),
                      ),),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/4+25,top: MediaQuery.of(context).size.height/9-30),
                      width: 130.0,
                      height: 130.0,
                      decoration:  BoxDecoration(
                          border: Border.all(color:Color(0xfff29a94),width: 3 ),
                          shape: BoxShape.circle,
                          image:  DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(info["profilimage"]),
                          )
                      )),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: IconButton(icon: Icon(Icons.trending_flat,textDirection: TextDirection.rtl,color: Colors.grey.shade200,size: 30,),
                        onPressed: (){
                          var route = MaterialPageRoute(builder: (context)=>DoctorsList(nom: info["grad"],));
                          Navigator.pop(context, route);
                        }),
                  ),
                ],
              ),
              Center(
                child:  Text(info["nom"],
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Montserrat',
                    color: Color(0xfff29a94),
                  ),
                ),
              ),
              Center(
                child:  Text(info["grad"],
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Montserrat',
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              Center(
                child:  Text("add this doctor to your favorite doctors",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      print("");
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 8,left: MediaQuery.of(context).size.width/9),
                      child: Text("Recomendé",style: TextStyle(fontSize: 18,color: Color(0xff5097a4)),),
                      padding:  EdgeInsets.only(left: 18,right: 20,top: 9,bottom: 9),
                      decoration: BoxDecoration(
                          border: Border.all(color:Color(0xfff29a94),width: 1 ),
                          borderRadius: BorderRadius.circular(40)
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future:db.getUser(info['nom']),
                    builder: (context ,snapshoot){
                      return GestureDetector(
                        onTap: (){
                          _controller2.isCompleted
                          ? _controller2.reverse():
                          _controller2.forward();
                          Icon icon;
                          if(!snapshoot.hasData){
                            adddoc(
                              info["nom"],
                              info["profilimage"],
                              info["covimage"],
                              info['grad'],
                              info["exper"],
                              info['wilaya'],
                              info['location'],
                              info['timing'],
                              info['email'],
                              info['number'],
                              info['recomended'],);
                              icon = Icon(Icons.star,color: Colors.yellow.shade700,size : 35 );
                          }
                          else{
                            icon = Icon(Icons.star_border,color: Colors.yellow.shade700,size : 35 );
                            deldoc(info['nom']);
                          };
                          setState(() {
                            _icon = icon;
                          });
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 8,left: 12),
                            child: Text("Favorite",style: TextStyle(fontSize: 20,color: Color(0xff5097a4)),),
                            padding:  EdgeInsets.only(left: 20,right: 20,top: 9,bottom: 9),
                            decoration: BoxDecoration(
                                border: Border.all(color:Color(0xfff29a94),width: 1 ),
                                borderRadius: BorderRadius.circular(40)
                            )
                        ),
                      );
                    },
                  )
                ],

              ),
              Row(
                children: <Widget>[
                  Container(
                    padding:EdgeInsets.all(7),
                    margin: EdgeInsets.only(top: 10,left: 20),
                    child: Column(
                      children: <Widget>[
                        Text("Recomended by",style: TextStyle(color: Colors.black87,fontSize: 15),),
                        Text("${info["recomended"]} person",style: TextStyle(color: Colors.blueGrey.shade200,fontSize: 14),),
                      ],
                    ),
                  ),
                  Container(height: 45, child: VerticalDivider(color: Colors.blueGrey)),
                  Container(
                    padding:EdgeInsets.all(7),
                    margin: EdgeInsets.only(top: 10,left: 8),
                    child: Column(
                      children: <Widget>[
                        Text("Experience",style: TextStyle(color: Colors.black87,fontSize: 16),),
                        Text("${info["exper"]}",style: TextStyle(color: Colors.blueGrey.shade200,fontSize: 14),),
                      ],
                    ),
                  ),
                  Container(height: 45, child: VerticalDivider(color: Colors.blueGrey)),
                  Transform.rotate(
                    angle: _animation.value,
                    child: Container(
                      padding:EdgeInsets.all(0),//4
                      margin: EdgeInsets.only(top:0 ,left: 8),
                     child: _icon==null ? (docEx ?Icon(Icons.star,color: Colors.yellow.shade700,size : 35 ) : Icon(Icons.star_border,color: Colors.yellow.shade700,size: 35,)): _icon),
                  ) ,
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 17),
                child: Text("Doctor image",style: TextStyle(color:Color(0xfff29a94) ),),
              ),
              Container(
                height: 120,
                child: StreamBuilder(
                  stream :  Firestore.instance.collection("Ent").document("H4MWo304omJ1enA5QIOf").collection("img").document("img").snapshots(),
                  builder:(context , snapshot){
                    if(snapshot.hasData){
                      return ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: makelist(snapshot),
                      );
                    }
                    else {return Center(child : CircularProgressIndicator());}
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Container(child: Icon(Icons.not_listed_location,color: Color(0xfff29a94),),margin: EdgeInsets.only(left: 5,top: 10),),
                  Container(child: Text("Location",style: TextStyle(fontSize: 15,color: Color(0xfff29a94)),),margin: EdgeInsets.only(left:1,top: 10),),
                ],),
              Row(
                children: <Widget>[
                  Container(child: Icon(Icons.remove,color: Color(0xfff29a94),),margin: EdgeInsets.only(left: 5,top: 10),),
                  Container(child: Text("${info["wilaya"]} -Bordj Ghedir",style: TextStyle(fontSize: 18,color: Colors.blueGrey.shade400),),margin: EdgeInsets.only(left:5,top: 10),),
                ],),
              Row(
                children: <Widget>[
                  Container(child: Icon(Icons.remove,color: Color(0xfff29a94),),margin: EdgeInsets.only(left: 5,top: 15),),
                  Container(child: Text("Zgandou -${info["wilaya"]}",style: TextStyle(fontSize: 18,color: Colors.blueGrey.shade400),),margin: EdgeInsets.only(left:5,top: 8),),
                ],),
              Row(
                children: <Widget>[
                  Container(child: Icon(Icons.access_time,color: Color(0xfff29a94),),margin: EdgeInsets.only(left: 5,top: 10),),
                  Container(child: Text("Timing",style: TextStyle(fontSize: 15,color: Color(0xfff29a94)),),margin: EdgeInsets.only(left:1,top: 10),),
                ],),
              Container(
                padding: EdgeInsets.only(left: 17),
                child: Text("from satuarday to friady\n"
                    "9:00 AM - 12:00 AM\n"
                    "2:00 PM - 6:00 PM",style: TextStyle(fontSize: 18,color: Colors.blueGrey.shade400),),margin: EdgeInsets.only(left:5,top: 10),),
              Row(
                children: <Widget>[
                  Container(child: Icon(Icons.info,color: Color(0xfff29a94),),margin: EdgeInsets.only(left: 5,top: 10),),
                  Container(child: Text("Contact",style: TextStyle(fontSize: 15,color: Color(0xfff29a94)),),margin: EdgeInsets.only(left:1,top: 10),),
                ],),
              Row(
                children: <Widget>[
                  Container(child: Icon(Icons.phone,color: Colors.blueGrey.shade400,),margin: EdgeInsets.only(left: 5,top: 10),),
                  Container(child: Text("${info["number"]}",style: TextStyle(fontSize: 18,color: Colors.blueGrey.shade400),),margin: EdgeInsets.only(left:12,top: 10),),
                ],),
              Row(
                children: <Widget>[
                  Container(child: Icon(Icons.mail_outline,color: Colors.blueGrey.shade500,),margin: EdgeInsets.only(left: 5,top: 16),),
                  Container(child: Text(info["email"],style: TextStyle(fontSize: 18,color: Colors.blueGrey.shade400),),margin: EdgeInsets.only(left:12,top: 10),),
                ],),
              Row(
                children: <Widget>[
                  Container(child: Icon(Icons.location_searching,color: Color(0xfff29a94),),margin: EdgeInsets.only(left: 5,top: 10),),
                  Container(child: Text("MAP",style: TextStyle(fontSize: 15,color: Color(0xfff29a94)),),margin: EdgeInsets.only(left:6,top: 10),),
                  GestureDetector(
                      onTap: (){
                        Route route = MaterialPageRoute(builder: (context)=>HomePage());
                        Navigator.push(context, route);
                      },
                      child: Container(child: Text("(double click to go to google map ...)",style: TextStyle(fontSize: 15,color: Colors.blueGrey.shade200),),margin: EdgeInsets.only(left:6,top: 10),)),
                ],),
              SizedBox(height: 4,),
              buildgooglemap(context),
            ],
          ),

        ),
      ),
    );
  }

  Mycontainer(String image) {
    return  Container(
      margin: EdgeInsets.only(
        top: 8,
        bottom: 8,
        right: 12,
        left: 12,
      ),
      width: 80,
      height: 20,
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(image),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 1,
            )
          ],
          borderRadius: BorderRadius.circular(12)

      ),
    );
  }
  Widget buildgooglemap(BuildContext context){
    return GestureDetector(
      onDoubleTap: (){
        Route route = MaterialPageRoute(builder: (context)=>HomePage());
        Navigator.push(context, route);
      },
      child: Container(
        height: MediaQuery.of(context).size.height/2,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(target: LatLng(35.904436, 4.898395),zoom: 14),
          mapType: MapType.normal,
          onMapCreated:(GoogleMapController controller){
            Completer<GoogleMapController> _controller = Completer();
            _controller.complete(controller);
          },
//          markers: {clinique1,clinique2},
        ),
      ),
    );
  }



    void adddoc(String name,String image ,String covimage,
    String grad , String exp ,String wilaya , String location,String timing,String email,String number,int recomended,
    )async {
    var db =  DatabaseHelper();
    await db.saveUser(new User(name,image,covimage,
    grad,exp,wilaya,location,timing,email,number,recomended
    ));

    }
    void deldoc(String name,)async {
    var db =  DatabaseHelper();
    await db.deleteUser(name);}
  void call(var tel) {
    launch(tel);
  }
  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You will never be satisfied.'),
                Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Regret'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  makelist(AsyncSnapshot snapshot) {
    List<Widget> list = [];
    for(int i=0;i< snapshot.data['pg'].length;i++){
      list.add(Mycontainer(snapshot.data['pg'][i]));
    }
    return list;
  }




}

