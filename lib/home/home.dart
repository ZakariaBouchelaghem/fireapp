import 'dart:math';

import 'package:flutter/material.dart';
import 'doctors.dart';
import 'doctors_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpecialitiesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SpecialitiesListState();
  }
}

class _SpecialitiesListState extends State<SpecialitiesList> with SingleTickerProviderStateMixin{

  final TextStyle dropdownMenuItem = TextStyle(
    color: Colors.blueGrey,
    fontSize: 18,
  );
  final primary = Color(0xff5097a4); //0xff696b9e
  final secondary = Color(0xfff29a94);
  final bGColor = Colors.white;

  Widget appBarTitle = Text(
    'Choose Specialitie',
    style: TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 21,
        fontWeight: FontWeight.w800,
        fontFamily: 'Montserrat'),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final TextEditingController _searchSpec = new TextEditingController();
  bool _IsSearching;
  String _searchText = "";
  Color searchColor = Colors.red.withOpacity(0.5);
  List<Spec> listRech ;

  //Monitor the instant change in the search text
  _SpecialitiesListState() {
    _searchSpec.addListener(() {
      //for the function of search
      if (_searchSpec.text.isEmpty) {
        setState(() {
          searchColor = Color(0xff696b9e).withOpacity(0.5);
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          searchColor = Colors.white;
          _IsSearching = true;
          _searchText = _searchSpec.text;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bGColor,
        body: StreamBuilder(
          stream:Firestore.instance.collection("users").snapshots(),
          builder: (context , snapshot){
           if(snapshot.hasData){
    return CustomScrollView(

    slivers: <Widget>[
    /*ClipPath(
              clipper : WaveClipperTwo(),
            child :buildAppBar() ,),*/
    buildAppBar(),
    SliverPadding(
    padding: EdgeInsets.only(top: 8, left: 16.0, right: 16.0),
    sliver: SliverGrid(
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 250.0, //the max width of the card
    mainAxisSpacing: 1.0, //the height between cards
    crossAxisSpacing: 10.0, //the width between cards
    childAspectRatio: 0.8,
    ),
    delegate: SliverChildBuilderDelegate(
    (BuildContext context, int index){
    return (_searchText ==null || _searchText.toString() =="")?makelist(snapshot).elementAt(index):
    makelist3(snapshot).elementAt(index);
    },
    childCount: (_searchText ==null || _searchText.toString() =="")?makelist(snapshot).length:makelist3(snapshot).length,
    ),
    ),
    ),
    ],
    );}
           else{return Center(child: CircularProgressIndicator());}
           }
        )
    );
  }

  Widget buildCard(BuildContext context, var document) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
       MaterialPageRoute(builder: (context)=>DoctorsList(nom:document["name"],)));
      }, // Go to the page of doctors
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.blueGrey.shade50, //
        ),
        width: 160,
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 110,
              height: 110,
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 5, color: Colors.blueGrey[100]), //
                image: DecorationImage(
                  image: AssetImage(
                    "images/riaa.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    document['nom'],
                    style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        fontFamily: 'Markazi Text'),
                  ),
                  Text(
                    document['name'],
                    style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'Raleway'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildAppBar() {
    return SliverAppBar(
//      shape: ContinuousRectangleBorder(
//        borderRadius: BorderRadius.only(
//            bottomLeft: Radius.circular(40),
//            bottomRight: Radius.circular(30)),
//      ),
      backgroundColor: primary,
      snap: false,
      floating: false,
      pinned: true,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          child: Image(
            image: new AssetImage("images/bg2.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: appBarTitle,

      actions: <Widget>[
        //do the animation when you clique at the search Icon ,The search window appears
        new IconButton(
          icon: actionIcon,
          padding: EdgeInsets.only(right: 30),
          onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(
                  Icons.close,
                  color: Colors.white,
                );
                this.appBarTitle = new Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: TextField(
                      controller: _searchSpec,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      cursorColor: Theme.of(context).primaryColor,
                      style: dropdownMenuItem,
                      decoration: InputDecoration(
                          hintText: "Search Medical Specialities",
                          hintStyle:
                              TextStyle(color: Colors.blueGrey, fontSize: 16),
                          prefixIcon: Material(
                            elevation: 0.0,
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: Icon(
                              Icons.search,
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 13)),
                    ),
                  ),
                );

                _handleSearchStart();
              } else {
                _handleSearchEnd();
              }
            });
          },
        ),
      ],
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = Text(
        'Choose Specialitie',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      );
      _IsSearching = false;
      _searchSpec.clear();
    });
  }

  List<Widget> makelist(AsyncSnapshot snapshot) {
    return snapshot.data.documents.map<Widget>((document) {
          return buildCard(context, document);
    }).toList();
  }
  List<Widget> makelist2(AsyncSnapshot snapshot) {
    return snapshot.data.documents.map<Widget>((document) {
     if(document['name'].toString().toLowerCase().contains(_searchText.toString())|| document['name'].toUpperCase().toString().contains(_searchText.toString())
     || document['name'].toString().contains(_searchText.toString()))   {return buildCard(context, document);}
    }).toList();
  }
  List<Widget> makelist3(AsyncSnapshot snapshot) {
    List<Widget> list = [];
    for(int i=0 ; i<makelist2(snapshot).length;i++){
      if(makelist2(snapshot).elementAt(i)!= null){list.add(makelist2(snapshot).elementAt(i));}
    }
    return list;
  }


}
