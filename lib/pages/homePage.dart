import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:DevJams/Presentation/util.dart';
import 'package:DevJams/models/sharedPref.dart';
import 'package:DevJams/pages/loginScreen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:DevJams/models/global.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:DevJams/pages/introductoryPage.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key,}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}
 
class CustomPopupMenu {
  CustomPopupMenu({this.title, this.icon});
  String title;
  IconData icon;
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
  BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: background,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  ScrollController scrollController;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getEmail();
    getToken();
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

String token="";
String email="";
int currentIndex=0;
  
SharedPreferencesTest s = new SharedPreferencesTest();
Future<String> futureToken;
Future<String> futureEmail;
getToken() async{
    futureToken=s.getToken();
    futureToken.then((res){
    setState(() {
        token=res; 
    });

});}

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
  }


Widget bullet(){
    return new Container(
      height: 10.0,
      width: 10.0,
      decoration: new BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
    );
}

List<CustomPopupMenu> choices = <CustomPopupMenu>[
  CustomPopupMenu(title: 'Logout'),
];


 void _select(CustomPopupMenu choice) {
    
    if(choice.title=='Logout'){
     //currentIndex==0?logoutSkip(): 
     logOut();
      // s.setEmail("");
      // s.setLogincheck("false");
      // s.setToken("");
      // Navigator.of(context).popUntil((route) => route.isFirst);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));

    }
  }

  logOut() async{
//    if(currentIndex == 0){
      s.setEmail("");
      s.setLogincheck("false");
      s.setToken("");
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => IntroScreen()));
//    }
//
//     else{
//      setState(() {
//        _load=true;
//      });
//       Future fetchPosts(http.Client client) async {
//        print("In logout");
//
//        var response = await http.get(URL_LOGOUT, headers: {"Content-Type": "application/json", "Authorization":token},);
//
//        print(response.statusCode);
//        print(response.body);
//
//
//        if (response.statusCode == 200) {
//          setState(() {
//         _load=false;
//        });
//            s.setEmail("");
//            s.setLogincheck("false");
//            s.setToken("");
//          s.setListEmail([]);
//            Navigator.of(context).popUntil((route) => route.isFirst);
//            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => IntroScreen()));
//        }
//        else{
//          setState(() {
//         _load=false;
//        });
//          Fluttertoast.showToast(
//            msg: "Some error occured"
//          );
//        }
//      }
//
//      return FutureBuilder(
//
//          future: fetchPosts(http.Client()),
//          builder: (BuildContext context,AsyncSnapshot snapshot){
//            if(snapshot.data==null){
//              return Container(
//                child: Center(
//                  child: CircularProgressIndicator(),
//                ),
//              );
//
//            }
//            else{
//              return Container();
//
//            }
//          });
//      }
  }



  bool _load = false;

  @override
  Widget build(BuildContext context) {

    var flexibleSpaceWidget = new SliverAppBar(
      backgroundColor: background,
      expandedHeight: 80.0,
      elevation: 0,
      pinned: true,

      flexibleSpace: FlexibleSpaceBar(

//        titlePadding: EdgeInsets.only(left: 20,bottom: 10),

    ),
      actions: <Widget>[
//        new IconButton(
//          icon: Icon(Icons.power_settings_new, color: Colors.black, size: 30,),
//          onPressed: logOut,
//        )
      ],

    );



    Widget loadingIndicator =_load? new Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        child:Center( child:
        Container(
          height: 200,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
           gradient:RadialGradient(
             stops: [ 0.1,10],
             colors: [
               Colors.grey[200],
               Colors.grey[400],
             ],),
          ),
          child: new Padding(padding: const EdgeInsets.all(16.0),child: new Center(child:Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  Padding(padding: EdgeInsets.all(5),),
                  Text("Logging out",style: TextStyle(fontSize: 16.0 ,fontWeight: FontWeight.w500,decoration: TextDecoration.none),)
                ],
              )
          ) )),
        ))):new Container();

    return  Scaffold(

      backgroundColor: background,
      body: Stack(
        children: <Widget>[
        new DefaultTabController(

        length: 2,
        child: NestedScrollView(

          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              flexibleSpaceWidget,
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                   indicator:BoxDecoration(color: background),
                    isScrollable: true,
                    indicatorColor: background,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(child:Container(
                        color:background,
                          padding: EdgeInsets.only(left:32 ,right: 8),
                          child: Text("Timeline", style: TextStyle(fontSize: 26.0,fontWeight: FontWeight.w500),)),),
                      Tab(child:Container(
//                        color:background,
                        margin: EdgeInsets.only(left: 0,right: 32),
                        child:  Text("Map", style: TextStyle(fontSize: 26.0)),)),
                     ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body:SingleChildScrollView(

            child:  Container(
                height: double.parse((data.length*120+100).toString()),
              color: background,
              child: new TabBarView(

              children: <Widget>[
                DayOne(),
                DayTwo(),
            ],
          )),
        ),),
      ),
      loadingIndicator
      ]
      )
    );
  }
List<String> map=["lib/assests/mapa.png","lib/assests/mapb.png","lib/assests/mapc.png"];
 Widget DayTwo(){
    return Scaffold(
      backgroundColor: background,
        body: Container(
          height: MediaQuery.of(context).size.height,
child:ListView(
scrollDirection: Axis.horizontal,
   children: <Widget>[
     Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         Container(

           child: Image.asset(map[0]),),
         Container(

           child: Image.asset(map[1]),), Container(

           child: Image.asset(map[2]),)
       ],
     )



   ])
//ListView.builder(
//
//  scrollDirection: Axis.horizontal,
//    itemCount: 3,
//    shrinkWrap: true,
//    padding: EdgeInsets.all(1),
//
//    itemBuilder:(BuildContext ctxt, int index){
//
//      return Container(
//          padding: EdgeInsets.all(1),
//        child: Image.asset(map[index]),
//      );
//    }),
        )
    );
  }
  List<String> data=["Registraion","Inaugration","Dinner","Speaker","Speaker","Hack begins","Snacks","Break","Review 1","Speaker","Lunch","Hack","Snacks","Review 2","Hack","Dinner","Hack","Snacks","Pitch","Prize Distribution"];
  List<String> time=["7:00 - 8:00 pm","8:00 - 9:00 pm","9:00 - 10:00 pm ","10:00 - 11:00 pm","11:00 - 12:00 am","12:00 - 3:30 am","3:30 - 4:00 am","8:00 - 8:30 am","9:00 - 10:30 am","11:00 - 1:00 pm","1:00 - 3:00 pm","3:00 - 5:00 pm","5:00 - 5:30 pm","5:30 - 9:00 pm","7:00 - 9:00 pm","9:00 - 10:00 pm","10:00 - 1:00 am","1:00 - 1:30 am","2:00 - 5:00 am","5:00 - 6:00 am"];



  List<Color> colorsDialog=[yellow,blue,green,red];
  Widget DayOne(){
    return Scaffold(

        body:Container(
height: double.parse((data.length*140).toString()),
color: background,
        padding: EdgeInsets.only(top: 10.0, left:  MediaQuery.of(context).size.width/20),

        alignment: Alignment.centerLeft,
        child :ListView.builder(
            itemCount: data.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext ctxt, int index) {
              Color clr=colorsDialog[index%4];
              return index==0?SingleChildScrollView(

                  child: Container(
                      height: 150,
                      padding: EdgeInsets.only(left: 16,right: 16),
                      child:
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                            child:Text("20th October",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),)
                        ),
                        Row(
                          children: <Widget>[

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[

                                Container(
                                    height:40,
                                    width: 40,
//                              height: 20,
//                    width: (MediaQuery.of(context).size.width/10),
                                    decoration: BoxDecoration(
                                      shape:BoxShape.circle,
                                      color:clr,
                                    ),

                                    child:Text("  ")
                                ),
                                Container(
                                  width: 3,
                                  height: 81,
                                  color:index==4||index==16||index==19?background: Colors.black,
                                )
                              ],
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 5),
                                width: (MediaQuery.of(context).size.width/7)*5,
                                child:
                                ClipPath(
                                  clipper: BottomWaveClipper(),
                                  child: Container(

                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(8.0),bottomRight: Radius.circular(8.0)),
                                      color: clr,
                                    ),
                                    child: Container(
                                        margin: EdgeInsets.only(left: 50),
                                        child:Column(

                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(data[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                                        Text(time[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300))
                                      ],
                                    )),
                                  ),
                                ))
                          ],
                        )])
                  )):index==5?SingleChildScrollView(

                  child: Container(
                      height: 150,
                      padding: EdgeInsets.only(left: 16,right: 16),
                      child:
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child:Text("21st October",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),)
                            ),
                            Row(
                              children: <Widget>[

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[

                                    Container(
                                        height:40,
                                        width: 40,
//                              height: 20,
//                    width: (MediaQuery.of(context).size.width/10),
                                        decoration: BoxDecoration(
                                          shape:BoxShape.circle,
                                          color:clr,
                                        ),

                                        child:Text("  ")
                                    ),
                                    Container(
                                      width: 3,
                                      height: 81,
                                      color:index==4||index==16||index==19?background: Colors.black,
                                    )
                                  ],
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 5),
                                    width: (MediaQuery.of(context).size.width/7)*5,
                                    child:
                                    ClipPath(
                                      clipper: BottomWaveClipper(),
                                      child: Container(

                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(8.0),bottomRight: Radius.circular(8.0)),
                                          color: clr,
                                        ),
                                        child: Container(
                                            margin: EdgeInsets.only(left: 50),
                                            child:Column(

                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(data[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                                                Text(time[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300))
                                              ],
                                            )),
                                      ),
                                    ))
                              ],
                            )])
                  )):index==17?SingleChildScrollView(

                  child: Container(
                      height: 150,
                      padding: EdgeInsets.only(left: 16,right: 16),
                      child:
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child:Text("22nd October",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),)
                            ),
                            Row(
                              children: <Widget>[

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[

                                    Container(
                                        height:40,
                                        width: 40,
//                              height: 20,
//                    width: (MediaQuery.of(context).size.width/10),
                                        decoration: BoxDecoration(
                                          shape:BoxShape.circle,
                                          color:clr,
                                        ),

                                        child:Text("  ")
                                    ),
                                    Container(
                                      width: 3,
                                      height: 81,
                                      color:index==4||index==16||index==19?background: Colors.black,
                                    )
                                  ],
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 5),
                                    width: (MediaQuery.of(context).size.width/7)*5,
                                    child:
                                    ClipPath(
                                      clipper: BottomWaveClipper(),
                                      child: Container(

                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(8.0),bottomRight: Radius.circular(8.0)),
                                          color: clr,
                                        ),
                                        child: Container(
                                            margin: EdgeInsets.only(left: 50),
                                            child:Column(

                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(data[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                                                Text(time[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300))
                                              ],
                                            )),
                                      ),
                                    ))
                              ],
                            )])
                  )):SingleChildScrollView(

                  child:GestureDetector(
                  onTap: (){
//                    sendToServer("Jim Jam",)
                    
              },
                  child: Container(
                    height: 120,
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child:

                  Row(
                    children: <Widget>[

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[

                          Container(
                              height:40,
                              width: 40,
//                              height: 20,
//                    width: (MediaQuery.of(context).size.width/10),
                              decoration: BoxDecoration(
                                shape:BoxShape.circle,
                                color:clr,
                              ),

                              child:Text("  ")
                          ),
                          Container(
                            width: 3,
                            height: 80,
                            color:index==4||index==16||index==19?background: Colors.black,
                          )
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 5),
                          width: (MediaQuery.of(context).size.width/7)*5,
                          child:
                          ClipPath(
                            clipper: BottomWaveClipper(),
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(8.0),bottomRight: Radius.circular(8.0)),
                                color: clr,
                              ),
                              child:Container(
                                margin: EdgeInsets.only(left: 50),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(data[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                                  Text(time[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300))
                                ],
                              ),
                              )),
                          ))
                    ],
                  )
              )));

            }
    ),


        )
    );
  }

 Map<String , dynamic> body={
   "name":"",
   "des":""
 };
  sendToServer(String name,String des){

    setState(() {
      _load=true;
    });


    body["name"]='$name';
    body["des"]='$des';

    Future fetchPosts(http.Client client) async {
      print("yjhtgfdsyutrgds");
      var response = await http.post(
        URL_POSTJAM, headers: {"Content-Type": "application/json","Authorization":"$token"},
        body: json.encode(body),);

      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["email"] == email)
        {
//          setState(() {
//            _load=false;
//          });
//          s.setLogincheck('false');
          Fluttertoast.showToast(
              msg: "Congratulation",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey[700],
              textColor: Colors.white);
        }
        else if(data["err"] == "Not found"){
//          setState(() {
//            _load=false;
//          });
//          s.setLogincheck('false');
          Fluttertoast.showToast(
              msg: "Try Again",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey[700],
              textColor: Colors.white);
        }
        else {
          Fluttertoast.showToast(
              msg: "Try Again",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey[700],
              textColor: Colors.white);
//          print(data);
//          setState(() {
//            _load = false;
//          });
//          s.setLogincheck('true');
//          Navigator.of(context).pushNamedAndRemoveUntil(
////              '/homepage', (Route<dynamic> route) => false);
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
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo((size.width/10)+8,size.height);
    path.arcToPoint(Offset((size.width/10),size.height-8), radius: Radius.circular(8));

    path.lineTo(size.width/10, (size.height/3));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}