class User {
   int _id;
   String _nom;
   String _profilimage;
   String _covimage;
   String _grad;
   String _exper;
   String _wilaya;
   String _location;
   String _timing;
   String _email;
   String _number;
   int _recomended;
//  String _password;

  User(this._nom, this._profilimage,this._covimage,this._exper,this._grad,this._wilaya,this._location,this._timing,this._email,this._number,this._recomended);
  User.int(this._id,this._nom, this._profilimage,this._covimage,this._exper,this._grad,this._wilaya,this._location,this._timing,this._email,this._number,this._recomended);
//  User(this._name,this._password);

  User.map(dynamic obj) {
    this._nom = obj['nom'];
//    this._password = obj['password'];
    this._profilimage = obj['profilimage'];
    this._covimage = obj['covimage'];
    this._id = obj['id'];
    this._exper = obj['exp'];
    this._grad = obj['grad'];
    this._wilaya = obj['wilaya'];
    this._location = obj['location'];
    this._timing = obj['timing'];
    this._email = obj['email'];
    this._number = obj['number'];
    this._recomended = obj['recomended'];

  }

  //getters
  String get nom => _nom;


//  String get password => _password; //  String get location => _location;
//
  String get grad => _grad;
//
  String get wilaya => _wilaya;
//
  int get id => _id;
//
  String get profilimage => _profilimage;
//
  String get covimage => _covimage;

  String get exper => _exper;

  int get recomended => _recomended;


  //Map Connstructors

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["nom"] = _nom;
    map["profilimage"] = _profilimage;
    map["covimage"] = _covimage;
    map["exper"] = _exper;
    map["grad"] = _grad;
    map["wilaya"] = _wilaya;
    map["location"] = _location;
    map["email"] = _email;
    map["number"] = _number;
    map["timing"] = _timing;
    map["recomended"] = _recomended;
    if(id != null){
      map["id"] = _id;
    }
    return map;
  }

  User.fromMap(Map<String, dynamic> map){
    this._nom = map["nom"];
    this._profilimage = map["profilimage"];
    this._covimage = map["covimage"];
    this._exper = map["exper"];
    this._grad = map["grad"];
    this._wilaya = map["wilaya"];
    this._location = map["location"];
    this._id = map["id"];
    this._timing = map['timing'];
    this._email = map['email'];
    this._number = map['number'];
    this._recomended = map["recomended"];
  }
}

//class User {
//  String _username;
//  String _school;
//  String _grad;
//  int _id;
//
//  User(this._username, this._school,this._grad
//  );
//
//  User.map(dynamic obj) {
//    this._username = obj['username'];
//    this._school = obj['password'];
//    this._grad = obj['grad'];
//    this._id = obj['id'];
//  }
//
//  //getters
//  String get username => _username;
//
//  String get school => _school;
//
//  int get id => _id;
//
//  //Map Connstructors
//  Map<String, dynamic> toMap() {
//    var map = new Map<String, dynamic>();
//    map["username"] = _username;
//    map["school"] = _school;
//    map["grad"]=_grad;
//    if(id != null){
//      map["id"] = _id;
//    }
//    return map;
//  }
//
//  User.fromMap(Map<String, dynamic> map){
//    this._username = map["username"];
//    this._school = map["school"];
//    this._grad = map["grad"];
//    this._id = map["id"];
//  }
//}