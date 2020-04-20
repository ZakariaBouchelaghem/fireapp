import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../main.dart';


class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {


   sign(String name,String email,String password  ) async{
     FirebaseAuth auth = FirebaseAuth.instance;
     try{

       AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
       FirebaseUser user = result.user;

       UserUpdateInfo info = UserUpdateInfo();
       info.displayName = name;
       user.updateProfile(info);
       await user.sendEmailVerification();
       return true;
     }catch(e){
       if(e is PlatformException) {
         if(e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
           setState(() {
//             hinttext = "this accounte is already existe";
//             _email.text = "";
             hintemail = Colors.red.shade600;
             hintemail2 = Colors.red.shade600;
             print("dddddddddd$e");
           });
         }
       };
      return false;
     }
   }
   String hinttext = "Email... ";
   Color hintname  = Color(0xff5097a4);
   Color hintemail = Color(0xff5097a4);
   Color hintemail2 = Colors.grey;
   Color hintpassword = Color(0xff5097a4);

  String _searchText = null;
  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _password2 = TextEditingController();
  TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Container(
          child: Column(
              children: <Widget>
              [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("images/signup.png"),fit:   BoxFit.fill ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: MediaQuery.of(context).size.height/3+60,
                        left: 20,
                        right: 20,
                        child:  TextField(
                          onChanged: (_name){
                            setState(() {
                              hintname = Color(0xff5097a4);
                              hintemail = Color(0xff5097a4);
                              hintpassword = Color(0xff5097a4);

                            });
                          },
                          onTap: (){
                            setState(() {
                              hintname = Color(0xff5097a4);
                              hintemail = Color(0xff5097a4);
                              hintpassword = Color(0xff5097a4);                            });
                          },
                          cursorColor: hintname,
                          controller: _name,
                          decoration: InputDecoration(
//                    disabledBorder: OutlineInputBorder(
//                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                        borderSide: BorderSide(color: Color(0xff5097a4))),
//                    border: OutlineInputBorder(
//                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                        borderSide: BorderSide(color: Color(0xff5097a4))),
                            labelText: "Full Name ...",
                            hintText: "Full Name...",
                            labelStyle: TextStyle(color: hintname),

                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height/3+126,
                        left: 20,
                        right: 20,
                        child:  TextField(
                          onChanged: (_email){
                            setState(() {
                              hintname = Color(0xff5097a4);
                              hintemail = Color(0xff5097a4);
                              hintemail2 = Colors.grey;
                              hintpassword = Color(0xff5097a4);                            });
                          },
                          onTap: (){
                            setState(() {
                              hintname = Color(0xff5097a4);
                              hintemail = Color(0xff5097a4);
                              hintemail2 = Colors.grey;
                              hintpassword = Color(0xff5097a4);                            });
                          },
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: hintemail,
                          controller: _email,
                          decoration: InputDecoration(
//                            icon: Icon(Icons.vpn_key,color: Color(0xff5097a4),),
//                            disabledBorder: OutlineInputBorder(
//                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                                borderSide: BorderSide(color: Colors.black)),
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                                borderSide: BorderSide(color: Colors.black)),
                            labelText: hinttext,
                            labelStyle: TextStyle(color: hintemail),
                            hintText: hinttext,
                            hintStyle: TextStyle(color: hintemail2),


                          ),
                        ),
                      ),

                      Positioned(
                        top: MediaQuery.of(context).size.height/3+186,
                        left: 20,
                        right: 20,
                        child:  TextField(
                          onChanged: (_password){
                            setState(() {
                              hintname = Color(0xff5097a4);
                              hintemail = Color(0xff5097a4);
                              hintpassword = Color(0xff5097a4);                            });
                          },
                          onTap: (){
                            setState(() {
                              hintname = Color(0xff5097a4);
                              hintemail = Color(0xff5097a4);
                              hintpassword = Color(0xff5097a4);                            });
                          },
                          cursorColor: hintpassword,
                          obscureText: true,
                          controller: _password,
                          decoration: InputDecoration(
//                    disabledBorder: OutlineInputBorder(
//                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                        borderSide: BorderSide(color: Colors.black)),
//                    border: OutlineInputBorder(
//                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                        borderSide: BorderSide(color: Colors.black)),
                            labelText: "Password...",
                            hintText: "Password... ",
                            labelStyle: TextStyle(color: hintpassword),

                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height/3+244,
                        left: 20,
                        right: 20,
                        child:  TextField(
                          onChanged: (_password2){
                            setState(() {
                              hintname = Color(0xff5097a4);
                              hintemail = Color(0xff5097a4);
                              hintpassword = Color(0xff5097a4);                            });
                          },
                          onTap: (){
                            setState(() {
                              hintname = Color(0xff5097a4);
                              hintemail = Color(0xff5097a4);
                              hintpassword = Color(0xff5097a4);                            });
                          },
                          obscureText: true,
                          cursorColor: hintpassword,
                          controller: _password2,
                          decoration: InputDecoration(
//                    disabledBorder: OutlineInputBorder(
//                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                        borderSide: BorderSide(color: Colors.black)),
//                    border: OutlineInputBorder(
//                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                        borderSide: BorderSide(color: Colors.black)),
                            labelText: "Confirm password...",
                            labelStyle: TextStyle(color: hintpassword),
                            hintText: "Confirm password... ",

                          ),
                        ),
                      ),

                      Positioned(
                        top: MediaQuery.of(context).size.height-142,
                        left: 28,
                        right: 10,
                        child: Row(
                          children: <Widget>[
                            InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Text("do you have an accounte?",style: TextStyle(color: Colors.blueGrey.shade400,fontSize: 16),)),
                            GestureDetector(
                              onTap: ()async{
                                final email = _email.text.toString().trim();
                                final password = _password.text.toString().trim();
                                final password2 = _password2.text.toString().trim();
                                final name = _name.text.toString().trim();
                                bool result =false;
                                if(password == password2 && name.length > 3 && password.length >7   ){
                                   result = await sign(name , email , password);
                                }else{
                                  setState(() {
                                    hintpassword = Colors.red.shade600;
                                  });
                                }
                                if(name.length < 3 ){
                                  hintname = Colors.red.shade600;

                                }
                                if(email ==null || email ==""){
                                  hintemail = Colors.red.shade600;

                                }
                                if(result){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)  {
                                    return Myapp();
                                  }));
                                };
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 8,left: 22),
                                child: Text("Sign Up",style: TextStyle(fontSize: 18,color: Colors.white),),
                                padding:  EdgeInsets.only(left: 22,right: 24,top: 9,bottom: 9),
                                decoration: BoxDecoration(
                                    color: Color(0xff5097a4),
                                    border: Border.all(color:Color(0xff5097a4),width: 1 ),
                                    borderRadius: BorderRadius.circular(40)
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
//                      Positioned(
//                        top: MediaQuery.of(context).size.height-142,
//                        left: MediaQuery.of(context).size.width-85,
//                        child: Container(
//                          margin: EdgeInsets.only(top: 8,left: 22),
//                          padding:  EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
//                          decoration: BoxDecoration(
//                              color: Color(0xff5097a4),
//                              border: Border.all(color:Color(0xff5097a4),width: 1 ),
//                              borderRadius: BorderRadius.circular(40)
//                          ),
//                          child: Icon(Icons.arrow_back,textDirection: TextDirection.rtl,color: Colors.white,),
//                        ),
//                      )
                    ],
                  ),
                ),]
          ),
        ),
      ),
    );
  }
}
/////////////////////////////////////////////////////////
