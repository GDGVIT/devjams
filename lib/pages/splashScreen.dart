import 'dart:async';
import 'package:flutter/material.dart';
import 'package:DevJams/main.dart';
import 'package:DevJams/models/sharedPref.dart';
import 'package:DevJams/pages/loginScreen.dart';

class SplashScreen extends StatefulWidget {


  SplashScreen({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}
class _SplashScreenState extends State<SplashScreen> {

  SharedPreferencesTest s= new SharedPreferencesTest();

  Future<String> checkLogin;
  String setLogin = "false";


  _SplashScreenState({Key key });
  @override
  void initState() {
    super.initState();
   checkText();
    go();

  }

  checkText(){

    checkLogin=s.getLogincheck();
    checkLogin.then((res){
      setState(() {
        setLogin=res;
      });
    });

  }


  go(){
      Future.delayed(const Duration(seconds:3),()
    {

      if (setLogin == 'false' || setLogin == null) {
        new Future.delayed(
            const Duration(seconds: 0),

                () => Navigator.of(context).pushReplacementNamed('/login')

        );

        }
        else{
        new Future.delayed(
            const Duration(seconds: 0),
                () => Navigator.of(context).pushReplacementNamed('/homepage')

        );
        }
    });
  }





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
//          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
          alignment: Alignment(0, 0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
Container(
    width: 500,
    child:
            Image.asset('lib/assests/DevJamsLogo.png')),
            Padding(padding: EdgeInsets.all(8),),
            Text("By",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 21),),
            Padding(padding: EdgeInsets.all(8),),
            Image.asset('lib/assests/DSCVITLogo.png' , width: (MediaQuery.of(context).size.width/2), ),
//             Image.asset('lib/assests/logo.png' , width: (MediaQuery.of(context).size.width/2), height: 200.0,),

          ],
        ) ,
        )       
    );
  }
}