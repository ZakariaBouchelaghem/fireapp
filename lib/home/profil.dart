import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'doctors.dart';
import 'map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fireapp/databasehelper.dart';
import 'package:fireapp/modal.dart';


class Main extends StatefulWidget {
  var db =  DatabaseHelper();
  var info;
  Main({this.info});
  @override
  _MainState createState() => _MainState(info);
}

class _MainState extends State<Main> {
  bool a;
  Completer<GoogleMapController> _controller = Completer();
  var info;
  _MainState(this.info);
   var db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height /3-30 ,
                  decoration: BoxDecoration(
                      color:Color(0xff5097a4),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(13),
                        bottomRight: Radius.circular(13),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(info["covimage"]),
                        fit: BoxFit.fill,
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  child: IconButton(
                      icon: Icon(Icons.keyboard_backspace,color:Colors.white,size: 35,),
                      onPressed: () {
                        Route route = MaterialPageRoute(builder: (context)=>DoctorsList(nom: info['grad'],));
                        Navigator.pop(context,route);
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25,left: MediaQuery.of(context).size.width-50),
                  child: IconButton(
                      icon: FutureBuilder<User> (
                        future: db.getUser(info["nom"]),
                        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                          if (snapshot.hasData) {
                              a = true;
                              return Icon(Icons.star, size: 35, color: Colors.yellow.shade700,);
                          }
                           else {
                              a = false;
                            return Icon(Icons.star_border, size: 35, color: Colors.white,);
                          }
                        },
                      ),
                      onPressed: () async{
                        setState(() {
                          if(a == false) {
                             Icon(Icons.star, size: 35, color: Colors.yellow.shade700,);
                            adddoc(
                              info["nom"], info["profilimage"],
                              info["covimage"], info['grad'],
                              info["exper"], info['wilaya'], info['location'] ,
                              info['timing'], info['email'],
                              info['number'], info['recomended'],
                            );
                          }
                          else  {
                             Icon(Icons.star_border, size: 35, color: Colors.white,);
                            deldoc(info['nom'],
                            );
                          }
                        });
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height /4-25,
                      left: MediaQuery.of(context).size.width /2-50),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:Colors.blueGrey,
                      image: DecorationImage(
                        image: NetworkImage(info["profilimage"]),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
              ],
            ),
          ),

          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(info['nom'],
                  //
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:25,
                    color: Colors.black,
                  ),),
                Text(info['grad'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xff5097a4),
                  ),),
              ],
            ),
          ),
          Container(
            height: 120,
            width: 60,
             child: StreamBuilder(
    stream:Firestore.instance.collection("users").document("H4MWo304omJ1enA5QIOf").collection("img").snapshots(),
               builder: (context ,snapshot) {
                 print("22222222222221${snapshot.data["ph"]}");
                 switch(snapshot.connectionState){
                   case ConnectionState.waiting:
                     return Center(child: CircularProgressIndicator(backgroundColor:Color(0xff5097a4)));
                   default:
                     return ListView(
                       shrinkWrap: true,
                       scrollDirection: Axis.horizontal,
                       children: makelist(snapshot),
                     );
                 }
               },
             ),
//            child: ListView(
//              shrinkWrap: true,
//              scrollDirection: Axis.horizontal,
//              children: <Widget>[
//                Container(
//                  margin: EdgeInsets.only(
//                    top: 8,
//                    bottom: 8,
//                    right: 12,
//                  ),
//                  width: 80,
//                  height: 10,
//                  decoration: BoxDecoration(
//                      color: Colors.white,
//                      border: Border.all(color: Color(0xff5097a4)),
//                      image: DecorationImage(
//                        fit: BoxFit.cover,
//                        image: AssetImage("images/ph11.jpeg"),
//                      ),
//
//                      boxShadow: [
//                        BoxShadow(
//                          color: Colors.black.withOpacity(0.1),
//                          blurRadius: 2,
//                          spreadRadius: 1,
//                        )
//                      ],
//                      borderRadius: BorderRadius.circular(12)
//
//                  ),
//                ),
//                Container(
//                  margin: EdgeInsets.only(
//                    top: 8,
//                    bottom: 8,
//                    right: 12,
//                  ),
//                  width: 80,
//                  height: 10,
//                  decoration: BoxDecoration(
//                      color: Colors.white,
//                      border: Border.all(color: Color(0xff5097a4)),
//                      image: DecorationImage(
//                        fit: BoxFit.cover,
//                        image: AssetImage("images/ph7.jpeg"),
//                      ),
//
//                      boxShadow: [
//                        BoxShadow(
//                          color: Colors.black.withOpacity(0.1),
//                          blurRadius: 2,
//                          spreadRadius: 1,
//                        )
//                      ],
//                      borderRadius: BorderRadius.circular(12)
//
//                  ),
//                ),
//                Container(
//                  margin: EdgeInsets.only(
//                    top: 8,
//                    bottom: 8,
//                    right: 12,
//                  ),
//                  width: 80,
//                  height: 10,
//                  decoration: BoxDecoration(
//                      color: Colors.white,
//                      border: Border.all(color: Color(0xff5097a4)),
//                       image: DecorationImage(
//                        fit: BoxFit.cover,
//                        image: AssetImage("images/ph8.jpeg"),
//                      ),
//
//                      boxShadow: [
//                        BoxShadow(
//                          color: Colors.black.withOpacity(0.1),
//                          blurRadius: 2,
//                          spreadRadius: 1,
//                        )
//                      ],
//                      borderRadius: BorderRadius.circular(12)
//
//                  ),
//                ),
//                Container(
//                  margin: EdgeInsets.only(
//                    top: 8,
//                    bottom: 8,
//                    right: 12,
//                  ),
//                  width: 80,
//                  height: 10,
//                  decoration: BoxDecoration(
//                      color: Colors.white,
//                      border: Border.all(color: Color(0xff5097a4)),
//                      image: DecorationImage(
//                        fit: BoxFit.cover,
//                        image: AssetImage("images/ph10.jpeg"),
//                      ),
//
//                      boxShadow: [
//                        BoxShadow(
//                          color: Colors.black.withOpacity(0.1),
//                          blurRadius: 2,
//                          spreadRadius: 1,
//                        )
//                      ],
//                      borderRadius: BorderRadius.circular(12)
//
//                  ),
//                ),
//                Container(
//                  margin: EdgeInsets.only(
//                    top: 8,
//                    bottom: 8,
//                    right: 12,
//                  ),
//                  width: 80,
//                  height: 10,
//                  decoration: BoxDecoration(
//                      color: Colors.white,
//                      border: Border.all(color: Color(0xff5097a4)),
//                      image: DecorationImage(
//                        fit: BoxFit.cover,
//                        image: AssetImage("images/ph12.jpeg"),
//                      ),
//
//                      boxShadow: [
//                        BoxShadow(
//                          color: Colors.black.withOpacity(0.1),
//                          blurRadius: 2,
//                          spreadRadius: 1,
//                        )
//                      ],
//                      borderRadius: BorderRadius.circular(12)
//
//                  ),
//                ),
//
//              ],
//            ),
          ),
          Divider(color: Colors.blueGrey.shade200,),
          ListTile(
            leading: Icon(Icons.business_center,color: Color(0xff5097a4),),
            title: Text("Experience",),
            subtitle: Text(info['exper']),
          ),//
          Divider(color: Colors.blueGrey.shade200,),
          ListTile(
            leading: Icon(Icons.school,color: Color(0xff5097a4),),
            title: Text("Graduation"),
            subtitle: Text(info['grad']),
          ),
          Divider(color: Colors.blueGrey.shade200,),
          ListTile(
            leading: Icon(Icons.access_time,color: Color(0xff5097a4),),
            title: Text("Timing"),
            subtitle: Text(info['timing']),
          ),

          Divider(color: Colors.blueGrey.shade200,),
          ListTile(
            leading: Icon(Icons.email,color: Color(0xff5097a4),),

            title: Text("E-mail"),
            subtitle: Text(info["email"]),
          ),
          Divider(color: Colors.blueGrey.shade200,),
          ListTile(
            leading: Icon(Icons.star,color: Color(0xff5097a4),),
            title: Text("Recomended "),
            subtitle: Text(info['nom'] +" recomnded by  ${info["recomended"]} personnes"),
          ),

          Divider(color: Colors.blueGrey.shade200,),
          ListTile(
            leading: Icon(Icons.location_on,color: Color(0xff5097a4),),
            title: Text(info["location"]+
                "\n "),
          ),
          Container(
            height: 300,
            child: buildgooglemap(context),
          ),
          Container(
            color: Colors.grey.shade200,
            child: Row(
                children: <Widget>[

                  Expanded(
                    flex: 6,
                    child: GestureDetector(
                      onTap: (){
                        call("tel:"+info["number"]);
                      },
//                      focusColor: Colors.indigo,
                      child: Container(
                        margin: EdgeInsets.only(right: 12,top: 3,bottom: 3,left: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:  Color(0xff5097a4),
                          border: Border.all(color: Colors.white),
                        ),
                        height: 55,
//                        padding: EdgeInsets.all(0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.phone,size: 26,color: Colors.white,),
                            new Text("   Call Now   ",
                              style: TextStyle(fontSize: 18,
                                  color: Colors.white),
                              textAlign: TextAlign.left,),
                          ],
                        ),
                      ),

                    ),
                  ),


                  Expanded(
                    flex: 6,
                    child: GestureDetector(

//                      focusColor: Colors.indigo,


                      child: Container(
                        margin: EdgeInsets.only(right: 12,top: 3,bottom: 3,left: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Color(0xff5097a4)),
                        ),
                        height: 55,
//                        padding: EdgeInsets.all(0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.add,color: Color(0xff5097a4),size:30,),
                            new Text(" Recomended  ",
                              style: TextStyle(fontSize: 18,
                                  color: Color(0xff5097a4)),
                              textAlign: TextAlign.left,),
                          ],
                        ),
                      ),

                    ),
                  ),
                ]
            ),
          ),
        ],
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


}




  Widget buildgooglemap(BuildContext context){
    return GestureDetector(
      onDoubleTap: (){
        Route route = MaterialPageRoute(builder: (context)=>HomePage());
        Navigator.push(context, route);
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(target: LatLng(35.904436, 4.898395),zoom: 14),
          mapType: MapType.normal,
          onMapCreated:(GoogleMapController controller){
            Completer<GoogleMapController> _controller = Completer();
            _controller.complete(controller);
          },
          markers: {clinique1,clinique2},
        ),
      ),
    );
  }

List<Widget> makelist(AsyncSnapshot snapshot) {
  return snapshot.data.documents.map<Widget>((document) {
    return Image(image: NetworkImage(document["ph"]),);
  }).toList();
}


void call(var tel) {
  launch(tel);
}




