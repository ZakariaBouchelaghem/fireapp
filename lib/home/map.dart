import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'profil.dart';




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
        leading: FlatButton(child: Icon(Icons.keyboard_backspace,color: Colors.white,size: 24,),
         onPressed: (){
          Route route = MaterialPageRoute(builder: (context)=>Main());
          Navigator.pop(context);
         },
        ),
        backgroundColor: Color(0xff5097a4),
      ),
      body: Stack(
        children: <Widget>[
          buildgooglemap(context),
          _buildContainer(),
        ],
      ),
    );
  }
  Widget buildgooglemap(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(35.904436, 4.898395),zoom: 15),
        mapType: MapType.normal,
        onMapCreated:(GoogleMapController controller){
          _controller.complete(controller);
        },
        markers: {clinique1,clinique2},
      ),
    );
  }


      Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 47,),
        height: 140.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 0.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "images/ph13.jpeg",
                  35.907621, 4.895127,""),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "images/ph13.jpeg",
                  35.904436, 4.898395,""),
            ),


          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat,double long,String restaurantName) {

    return  GestureDetector(
      onTap: () {
        _gotoLocation(lat,long);
      },
      child:Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 4.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0xff5097a4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(_image),
                      ),
                    ),),
                  Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    width: 180,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 0),
                            child: Text("hospital belhdad toumi.\n",
                              style: TextStyle(
                                  color: Color(0xff5097a4),
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text("-next to police office, "
                              "rue mohamed boudhiaf",
                            style: TextStyle(
                                color: Colors.blueGrey.shade200,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("- hospital for cardilougue doctors",
                            style: TextStyle(
                                color: Colors.blueGrey.shade200,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  ),

                ],)
          ),
        ),
      ),
    );
  }



  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }
}


Marker clinique1 = Marker(
  markerId: MarkerId('Bordj ghadir'),
  position: LatLng(35.904436, 4.898395),
  infoWindow: InfoWindow(title: 'Hospital'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueGreen,
  ),
);

Marker clinique2 = Marker(
  markerId: MarkerId('Bordj ghadir2'),
  position: LatLng(35.907621, 4.895127),
  infoWindow: InfoWindow(title: 'clinique'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueGreen,
  ),
);


