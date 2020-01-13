import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:DevJams/Presentation/util.dart';
import 'package:DevJams/models/sharedPref.dart';
import 'package:DevJams/pages/contactUsPage.dart';
import 'package:DevJams/pages/homePage.dart';
import 'package:DevJams/pages/loginScreen.dart';
import 'package:DevJams/pages/partnersPage.dart';
import 'package:DevJams/pages/qrCodePage.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:DevJams/Presentation/my_flutter_app_icons.dart';
import 'dart:convert';
import 'package:DevJams/pages/introductoryPage.dart';
import 'dart:io';

import 'package:DevJams/pages/splashScreen.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(new MyApp());
  }

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) =>
        MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), child: child),
        title: 'DevJams',
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home : SplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/start':(BuildContext context)=>SplashScreen(),
          '/homepage': (BuildContext context) => MyHomePage(),
          '/intro':(BuildContext context)=>IntroScreen(),
          '/login':(BuildContext context)=>LoginScreen()
        }
     );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.personID, this.personName}) : super(key: key);

  String personName, personID;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  TextEditingController controller = TextEditingController();

  SharedPreferencesTest s =new SharedPreferencesTest();

  int _selectedIndex = 0;
  final _widgetOptions = [
    HomePage(),
    PartnersPage(),
    LeaderboardPage(),
    ContactUsPage()
  ];


  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();

}


  bool boolToString(String value){
    if(value == "true"){
      return true;
    }
    else if(value == "false"){
      return false;
    }
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit the application'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => exit(0),
            child: new Text('Yes'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: new Text('No'),
          ),
        ],
      ),
    ) ?? false;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
      onWillPop: _onWillPop,
        child : Scaffold(
          backgroundColor: background,
          body:_widgetOptions[_selectedIndex],
          bottomNavigationBar:
//          BottomNavigationBar(
//            items: const <BottomNavigationBarItem>[
//              BottomNavigationBarItem(
//                icon:Icon(MyFlutterApp.home,color: unselected,),
////                title: Text('Home'),
//              ),
//              BottomNavigationBarItem(
//               icon:Icon(MyFlutterApp.info_outline,color: unselected,),
////                title: Text('Business'),
//              ),
//              BottomNavigationBarItem(
//                icon:Icon(MyFlutterApp.medal,color: unselected,),
////                title: Text('School'),
//              ),
//              BottomNavigationBarItem(
//                icon:Icon(MyFlutterApp.user,color: unselected,),
////                title: Text('School'),
//              ),
//            ],
//            currentIndex: _selectedIndex,
//            selectedItemColor: red,
//            onTap: _onItemTapped,
//          ),
            BottomNavigationBar(
              items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon:Icon(MyFlutterApp.home,color: unselected,), activeIcon: Icon(MyFlutterApp.home,color:red,)),
              BottomNavigationBarItem(icon:Icon(MyFlutterApp.info_outline,color: unselected), activeIcon: Icon(MyFlutterApp.info_outline,color: yellow,),),
              BottomNavigationBarItem(icon:Icon(MyFlutterApp.medal,color: unselected), activeIcon: Icon(MyFlutterApp.medal,color: green,)),
              BottomNavigationBarItem(icon:Icon(MyFlutterApp.user,color: unselected), activeIcon: Icon(MyFlutterApp.user,color:blue,),),
              ],
              currentIndex: _selectedIndex,
                fixedColor: Colors.blue,
                onTap: _onItemTapped,
            ),
     ) );
  }
}