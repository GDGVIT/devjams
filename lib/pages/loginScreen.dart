import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:DevJams/Presentation/util.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:DevJams/models/sharedPref.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:DevJams/models/logincl.dart';
import 'package:DevJams/models/global.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  GlobalKey<FormState> _key = new GlobalKey();


    @override
    void initState() {
    super.initState();
  }

  String tokenValue ;
  bool _validate = false;
  String email,password;

  SharedPreferencesTest s=new SharedPreferencesTest();

  Logincl logincl;


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     body: new Form(
      key: _key,
      autovalidate: _validate,
      child: FormUI(),
    ), );
  }

  bool _load = false;
  Map<String,dynamic> body=
  {
    "email": "angadsharma1016@gmail.com",
    "password": "124c18an",
    "device_id": "dflsdknflksdanflanddsakdfnsaKLFDJBNK"
  };



  Widget FormUI() {

    Widget loadingIndicator =_load? new Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        child: Center( child:
        Container(
          height: MediaQuery.of(context).size.height/4,
          width: MediaQuery.of(context).size.width,
          child: new Padding(padding: const EdgeInsets.all(16.0),child: new Center(child:Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  Padding(padding: EdgeInsets.all(5),),
                  Text("Logging in...",style: TextStyle(fontSize: 16.0 ,fontWeight: FontWeight.w500,decoration: TextDecoration.none),)
                ],
              )
          ) )),
        ))):new Container();

    return  Scaffold(

    body:Stack(
      children: <Widget>[

      SingleChildScrollView(
      child : Container(
        height: MediaQuery.of(context).size.height-60,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16.0),
        color:white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Container(
          width: 500,
          child:
            Image.asset('lib/assests/dev.webp' ,)),
            Padding(padding: EdgeInsets.all(8),),
Text("By",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 21),),
            Padding(padding: EdgeInsets.all(8),),
            Image.asset('lib/assests/DSCVITLogo.png' , width: (MediaQuery.of(context).size.width/2), ),
            Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/20),
                padding: EdgeInsets.only(left: 16.0,right:16.0,top: 26.0),
                child: TextFormField(
                    style: TextStyle(color: Colors.blue,fontFamily: 'Raleway'),
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Username',
                        labelText: 'Username'
                    ),
                    validator: validateEM,
                    onSaved: (String val) {
                      email= val;
//                      print("Code"+code);
                    }
                )
            ),
            Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/20),
                        padding: EdgeInsets.only(left: 16.0,right:16.0),
                        child: TextFormField(
                            style: TextStyle(color: Colors.blue,fontFamily: 'Raleway'),
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Password',
                                labelText: 'Password'
                            ),
                            validator: validateEM,
                            onSaved: (String val) {
                              password = val;
//                              print("Code"+code);
                            }
                        )
                    ),
                  GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/20),
                        width: MediaQuery.of(context).size.width-100,
                        height: 55.0,
                        alignment: Alignment.center,
                         decoration: BoxDecoration(
                           color: blue,

//                                                              gradient: LinearGradient(
//                                                                begin: Alignment.topRight,
//                                                                end: Alignment.bottomLeft,
//                                                                stops: [ 0.1,0.3,0.7,0.9],
//                                                                colors: [
//Color(0xFF2196F3),
// Color(0xFF1E88E5),
//  Color(0xFF1976D2),
//                                                                  Color(0xFF1565C0),
//
//
//
//
//
//
//                                                                ],),
                                                            
                  boxShadow:<BoxShadow>[
                    BoxShadow(
                      blurRadius: 5.0,
                      color:Colors.grey[400] ,
                      offset: Offset(0.5,0.5)
                    )

                  ],
                  shape: BoxShape.rectangle,
              
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),

                        child : Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//                        padding: EdgeInsets.all(20.0),
                      ),
                    onTap: (){
                       sendToServer();
                    },
                  ),
//                    GestureDetector(
//                      child: Container(
//                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/20),
//                        alignment: Alignment.center,
//                        height: 55.0,
//                        width: MediaQuery.of(context).size.width/2,
//                         decoration: BoxDecoration(
//                  boxShadow:<BoxShadow>[
//                    BoxShadow(
//                      blurRadius: 5.0,
//                      color:Colors.grey[400] ,
//                      offset: Offset(0.5,0.5)
//                    )
//
//                  ],
//                  shape: BoxShape.rectangle,
//                  color: Colors.white,
//                  borderRadius: BorderRadius.all(Radius.circular(10))
//                ),
//                        child :Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//                            Image.asset('lib/assests/qr.png' , width: (MediaQuery.of(context).size.width/17), ),
//
//                            Text("QR Code", style: TextStyle (fontWeight: FontWeight.bold),),
//                          ],
//                        ) ,
//                        padding: EdgeInsets.all(20.0),
//                      ),
//                      onTap: (){
//                        _scanQR();
//                        },
//                    )
          ],
        )
        /*new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround ,
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                            Expanded(
                              child: Text(
                                        "Login",
                                          style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                      ),flex: 1,)
                          ],
                        ),
                        ),
                   /* Container(
                        padding: EdgeInsets.only(left: 16.0,right:16.0,top: 26.0),
                        child: Theme(
                          child: TextFormField(
                            style: TextStyle(color: Colors.blue,fontFamily: 'Raleway'),
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter your code',
                                labelText: 'Code'
                            ),
                            validator: validateEM,
                            onSaved: (String val) {
                              code = val;
                              print("Code"+code);
                            }
                        )
                        )
                    ),*/
                    GestureDetector(
                      child: Container(
                        child : Text("Login"),
                        padding: EdgeInsets.all(20.0),
                      ),
                      onTap: (){
                        _login_Server();
                        }, 
                    ),
                    GestureDetector(
                      child: Container(
                        child : Text("QR Code"),
                        padding: EdgeInsets.all(20.0),
                      ),
                      onTap: (){
                        _scanQR();
                        }, 
                    )
                  ],
        ),*/
              ),),
      new Align(child: loadingIndicator,alignment: FractionalOffset.center,),
    ]));
  }
List<String> emailList;
  String validateEM(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    String pattern1 = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp1 = new RegExp(pattern1);
    if(regExp.hasMatch(value) && (value.isNotEmpty)){
      if (value.length == 0) {
        return "Code is Required";
      } 
      return null;
    }
  }


  String result = "Press Scan";

  Future _scanQR() async {
    try {
      print("qwertyuiopsdfghjkzxcvbnm,");
      String qrResult =await  QRCodeReader().scan();
      if(qrResult!=null){
        sendToServerQR(qrResult);
      }
      else{
         Fluttertoast.showToast(
              msg: "QR Code Not Scanned",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey[700],
              textColor: Colors.white);
      }
    }

     on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    }
    catch (ex) {
      setState(() {
        print("Unknown Error $ex");
        result = "Nothing Scanned";
      });
    }
  }


  sendToServer(){
    if(_key.currentState.validate())
    {
      _key.currentState.save();
      setState(() {
        _load=true;
      });



      body["email"]='$email';
      body['password']='$password';

      Future fetchPosts(http.Client client) async {
        print("yjhtgfdsyutrgds");
        var response = await http.post(
          URL_LOGIN, headers: {"Content-Type": "application/json"},
          body: json.encode(body),);

        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if(data["err"]=="Max team login size reached" || data=={}){
            setState(() {
              _load=false;
            });
            s.setLogincheck('false');
            Fluttertoast.showToast(
              msg: "Max team login size reached",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey[700],
              textColor: Colors.white);
          }
          else if(data["err"] == "Not found"){
            setState(() {
              _load=false;
            });
            s.setLogincheck('false');
            Fluttertoast.showToast(
              msg: "Code not found",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey[700],
              textColor: Colors.white);
          }
          else if(data["message"]=="User does not exist"){
            setState(() {
              _load=false;
            });
            s.setLogincheck('false');
           Fluttertoast.showToast(
              msg: "User does not exist",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey[700],
              textColor: Colors.white);
          }
          else{
//            logincl=Logincl.fromJson(data);
//            emailList=logincl.teamMates;
//            emailList.add(logincl.email);
            s.setEmail(data["email"]);
//            print(emailList);
//            s.setPersonID(code);
//            s.setListEmail(emailList);
            s.setToken(data["token"]);
            s.setIndex(0);
            setState(() {
              _load=false;
            });
            print(data.toString());
            print("Email is "+data["email"]);
            s.setLogincheck('true');
            Navigator.of(context).pushNamedAndRemoveUntil('/homepage', (Route<dynamic> route) => false);
          }
        }
        else {
          setState(() {
            _load=false;
          });
          s.setLogincheck('false');
          Fluttertoast.showToast(
              msg: "Sorry, Server Error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey[700],
              textColor: Colors.white);
        }
      }


      print(body);

      return FutureBuilder(

          future: fetchPosts(http.Client()),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            }
            else{
              return Container();

            }
          });

    }



    else{

      // validation error
      setState(() {
        _validate = true;
      });

    }



  }
  sendToServerQR(String val){

    setState(() {
      _load=true;
    });


      body["passcode"]='$val';

      Future fetchPosts(http.Client client) async {
        print("yjhtgfdsyutrgds");
        var response = await http.post(
          URL_LOGIN, headers: {"Content-Type": "application/json"},
          body: json.encode(body),);

        print(response.statusCode);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data["err"] == "Max team login size reached")
          {
            setState(() {
              _load=false;
            });
            s.setLogincheck('false');
            Fluttertoast.showToast(
                msg: "Max team login size reached",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.grey[700],
                textColor: Colors.white);
          }
          else if(data["err"] == "Not found"){
            setState(() {
              _load=false;
            });
            s.setLogincheck('false');
            Fluttertoast.showToast(
                msg: "Code not found",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.grey[700],
                textColor: Colors.white);
          }
        else {
          print(data);
          logincl=Logincl.fromJson(data);
          emailList=logincl.teamMates;
          emailList.add(logincl.email);
          s.setEmail(data["email"]);
          s.setPersonID(val);
          print(emailList);
          s.setListEmail(emailList);
          s.setToken(data["token"]);
          s.setIndex(0);
          setState(() {
            _load = false;
          });
          s.setLogincheck('true');
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/homepage', (Route<dynamic> route) => false);
        }
      }
        else {
          setState(() {
            _load=false;
          });
          Fluttertoast.showToast(
              msg: "Sorry, Server Error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey[700],
              textColor: Colors.white);
        }
      }


      print(body);

      return FutureBuilder(

          future: fetchPosts(http.Client()),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            }
            else{
              return Container();

            }
          });












  }
}
