import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:DevJams/Presentation/util.dart';
import 'dart:convert';
import 'dart:async';
import 'package:DevJams/pages/loginScreen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:DevJams/models/sharedPref.dart';

class QRCodePage extends StatefulWidget {
  QRCodePage({Key key,this.restaurantID,this.workerID}) : super(key: key);
  final String restaurantID, workerID;

  @override
  _QRCodePageState createState() => _QRCodePageState();
}
class _QRCodePageState extends State<QRCodePage> {

  @override
  void initState() {
    super.initState(); 
    getEmail();
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  ScrollController scrollController;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  int currentIndex=0;
  String email="";
  String id="";
  int index=0;
  Future<int> futureIndex;

  SharedPreferencesTest s = new SharedPreferencesTest();
  Future<String> futureEmail;
  Future<List<String>> futureEmailList;
  Future<String> futureID;
  List<String> emailList;
  getEmail() async{

    futureEmail=s.getEmail();
    futureEmail.then((res){

      if(res.compareTo("")==0||res==null||res.compareTo("yo")==0){
      setState(() {
        email=res; 
        currentIndex=0;
    });
       }
       else{
          setState(() {
          email=res; 
          currentIndex=1;

    });
       }
    });


    futureEmailList=s.getListEmail();
    futureEmailList.then((res){
      setState(() {
        emailList=res;
      });
    });
    futureEmail=s.getPersonID();
    futureEmail.then((res){

        setState(() {
          id=res;


        });

    });
    futureIndex=s.getIndex();
    futureIndex.then((res){
      setState(() {
        index=res;
        selectedEmail=emailList[index];
      });
    });

  }

  String selectedEmail;

  @override
  Widget build(BuildContext context) {

    var flexibleSpaceWidget = new SliverAppBar(
      backgroundColor: background,
      expandedHeight: 120.0,
      elevation: 0,
      pinned: true,

      flexibleSpace: FlexibleSpaceBar(

        titlePadding: EdgeInsets.only(left: 20,bottom: 30),
        title: Container(
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(0),
          child : Text("QR Code",
            style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            ),

      ),),
    ),

    );

    print("Email is "+email+currentIndex.toString());
    return Scaffold(
    /*  appBar: AppBar(
        elevation: 0,
        title: Text('',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 23.0),),
        backgroundColor :background,

         bottom: PreferredSize(
child: 
Container(
   padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
child:Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
  Container( 
    //margin: EdgeInsets.fromLTRB(20, 8, 16, 8),
  child: Text("QR Code" , style: TextStyle(fontSize:24.0, fontWeight: FontWeight.w600, color: Colors.black),textAlign: TextAlign.left,),),
      
],)),
  preferredSize: const Size.fromHeight(50.0)),
     
     ),*/
      backgroundColor: background,
      body: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              flexibleSpaceWidget,
            ];
          },
          body:Center(
        child : currentIndex==0 ? noQrPage() : qrPage()
      ))
    );
}

Widget qrPage(){
  return Container(
    alignment: Alignment.center,
    child : LayoutBuilder(
    builder: (BuildContext context, BoxConstraints viewportConstraints) {
    return Container(
    padding: EdgeInsets.only(bottom:20.0),
    child: ConstrainedBox(
    constraints: BoxConstraints(
    minHeight: viewportConstraints.maxHeight,
    ),
    child: Column(
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Container(
        child: Column(
          children: <Widget>[
            Text("Select Email"),
            DropdownButton<String>(
              value: selectedEmail,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                  color: Colors.grey
              ),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String newValue) {
                setState(() {
                  selectedEmail= newValue;
                  int i= emailList.indexOf(newValue);
                  s.setIndex(i);
                });
              },
              items: emailList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),
          ],
        ),
      ),

      QrImage(
        data: selectedEmail,
        //version: 3,
        size: 200.0,
      ),
      Container(
        child: Column(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Email : ", style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/25),),
                    Text(selectedEmail,style: TextStyle(fontSize: MediaQuery.of(context).size.width/25),),


                  ],
                )
            ),
            Padding(padding: EdgeInsets.all(10),),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[


                    Text("Team ID : ", style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/30),),
                    Text(id,style: TextStyle(fontSize: MediaQuery.of(context).size.width/30),),

                  ],
                )
            )
          ],
        ),
      )

    ],),
    )
    );
    }
    ));
}

Widget noQrPage(){
  return Container(
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("Log in to redeem your coupons.",style: TextStyle(fontSize: 16),),
         GestureDetector(
                      child: Container(
                        // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/20),
                        width: MediaQuery.of(context).size.width/2,
                        alignment: Alignment.center,
                         decoration: BoxDecoration(

                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [ 0.1,0.3,0.7,0.9],
                            colors: [
                      Color(0xFF2196F3),
                      Color(0xFF1E88E5),
                        Color(0xFF1976D2),
                        Color(0xFF1565C0),
                      ],),
                                                            
                  boxShadow:<BoxShadow>[
                    BoxShadow(
                      blurRadius: 10.0,
                      color:Colors.grey[400] ,
                      offset: Offset(0.5,0.5)
                    )

                  ],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                        child : Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        padding: EdgeInsets.all(20.0),
                      ),
                      onTap: (){
                        s.setLogincheck('false');
                        Navigator.of(context).popUntil((route) => route.isFirst);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                        }, 
                    ),
      ],
    ),
  );
}
}

