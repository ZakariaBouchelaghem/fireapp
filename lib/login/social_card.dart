import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  final List<Color> colors;
  final String text;
  final ImageIcon photo;
  final Function onPressed;
  Register({this.colors, this.text,this.photo, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Container(
            height: 55.0,

            child:GestureDetector(
              onTap: onPressed,
              child :Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: colors, tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0),
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, -10.0),
                        blurRadius: 10.0),
                  ],

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 30.0,),
                    Center(
                      child: photo,
                    ),
                    SizedBox(width: 15.0),
                    Center(
                      child: Text(text,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    )
                  ],
                ),
              ),
            )));
  }
}