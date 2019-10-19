import 'package:flutter/material.dart';
import 'package:DevJams/Presentation/util.dart';
import 'package:DevJams/Presentation/my_flutter_app_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class EasterEgg extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  
    return EasterEggState();
  }
  
}

class EasterEggState extends State<EasterEgg>{


  _launchURLangad() async {
    const url = 'https://www.linkedin.com/in/angad-sharma-07bb38122/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURLprateek() async {
    const url = 'https://www.linkedin.com/in/prateek-mewara-0783b013b/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLayush() async {
    const url = 'https://www.linkedin.com/in/ayushpriya10/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLsatkriti() async {
    const url = 'https://www.linkedin.com/in/satkriti-singh-a82712155/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLnikhil() async {
    const url = 'https://www.linkedin.com/in/nikhil-singh-955995148/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold
    (
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: Colors.black, //change your color here
        ),
      title: Text("The Tech Team",style: TextStyle(color: Colors.black),),backgroundColor: background,centerTitle: true,
      elevation: 0,
    ),
    backgroundColor: background,
    body: SingleChildScrollView(
      child: Container(
         padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
           Container(
            padding: EdgeInsets.all(10.0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Made with"),
Padding(padding: EdgeInsets.all(2),),
Icon(MyFlutterApp.heart_1,size: 16,color: Colors.blue,),
                Padding(padding: EdgeInsets.all(2),),
                Text(" by "),
                Image.asset("lib/assests/dsclogo.png",height: 16,),
                Text(" DSC-VIT")

              ],
            )
          ),
          Image.asset("lib/assests/group_picture.jpg"),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text("From left to right:"),
          ),


        GestureDetector(
            onTap: (){
              _launchURLangad();
            },
            child:  Container(
            padding: EdgeInsets.only(top: 16.0, bottom: 5.0),
            child: Text("Angad Sharma", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 17.0),),
          )),
          Container(
            child: Text("(Backend Developer)"),
          ),
      GestureDetector(
        onTap: (){
          _launchURLprateek();
        },
         child: Container(
            padding: EdgeInsets.only(top: 16.0, bottom: 5.0),
            child: Text("Prateek Mewara", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 17.0),),
          )),

          Container(
            child: Text("(Android Developer)"),
          ),
      GestureDetector(
        onTap: (){
          _launchURLayush();
        },child:
          Container(
            padding: EdgeInsets.only(top: 16.0, bottom: 5.0),
            child: Text("Ayush Priya", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 17.0),),
          )),
          Container(
            child: Text("(Team Lead)"),
          ),
      GestureDetector(
        onTap: (){
          _launchURLsatkriti();
        },child:
          Container(
            padding: EdgeInsets.only(top: 16.0, bottom: 5.0),
            child: Text("Satkriti Singh", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 17.0),),
          )),
          Container(
            child: Text("(Android Developer)"),
          ),
      GestureDetector(
        onTap: (){
          _launchURLnikhil();
        },child:
          Container(
            padding: EdgeInsets.only(top: 16.0, bottom: 5.0),
            child: Text("Nikhil Singh", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 17.0),),
          )),
          Container(
            child: Text("(Frontend Developer)"),
          ),

        ],
      ),
    ) ),
    ) ;
  }

}