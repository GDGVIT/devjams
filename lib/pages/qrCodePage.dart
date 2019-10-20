import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:DevJams/Presentation/util.dart';
import 'package:DevJams/models/sharedPref.dart';
import 'package:DevJams/pages/loginScreen.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:DevJams/models/global.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:DevJams/pages/introductoryPage.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class LeaderboardPage extends StatefulWidget {
  LeaderboardPage({Key key,}) : super(key: key);

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

class _HomePageState extends State<LeaderboardPage> with TickerProviderStateMixin {

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
        child:Center(

            child:QrImage(
              data: email,
              //version: 3,
              size: MediaQuery.of(context).size.width,
            )
        )):new Container();

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
//                        color:background,
                                  padding: EdgeInsets.only(left:32 ,right: 8),
                                  child: Text("Hunt", style: TextStyle(fontSize: 26.0,fontWeight: FontWeight.w500),)),),
                              Tab(child:Container(
//                        color:background,
                                margin: EdgeInsets.only(left: 0,right: 32),
                                child:  Text("Leaderboard", style: TextStyle(fontSize: 26.0)),)),
                            ],
                          ),
                        ),
                        pinned: true,
                      ),
                    ];
                  },
                  body:SingleChildScrollView(

                    child:  Container(
                        height: double.parse((8*120+50).toString()),
                        color: background,
                        child: new TabBarView(

                          children: <Widget>[
                            DayOne(),
Container(

    child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Coming Soon",style: TextStyle(fontSize: 21),),
      ],
    )

)
//                            DayTwo(),
                          ],
                        )),
                  ),),
              ),
              loadingIndicator
            ]
        )
    );
  }

  Widget DayTwo(){
    return Scaffold(
      backgroundColor: background,
        body:Container(

          height: MediaQuery.of(context).size.height-200,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext ctxt, int index) {
                  return index==0?Stack(children: <Widget>[Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width-100,
                    margin: EdgeInsets.only(left:70,right: 32,bottom: 32),
                    decoration: BoxDecoration(
                        boxShadow:<BoxShadow>[
                          BoxShadow(blurRadius: 2.0,
                              color:Colors.grey[400] ,
                              offset: Offset(0.5,0.5))

                        ],
                        shape: BoxShape.rectangle,
                        color: Colors.white ,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child:Container(
                        margin: EdgeInsets.fromLTRB(50, 16, 0, 0),
                        child: Text("prateekmewara@gmail.com")),
                  ),Positioned(
                    left:55,
                    top: 10,
                    child: Container(
                      height:30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape:BoxShape.circle,
                        color:blue,
                      ),
                      child:Center(child: Text((index+1).toString(),style: TextStyle(color:white,fontWeight: FontWeight.w500,fontSize: 16),)),
                    ),
                  )

                  ]):index==1?Stack(children: <Widget>[Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width-100,
                    margin: EdgeInsets.only(left:70,right: 32,bottom: 32),
                    decoration: BoxDecoration(
                        boxShadow:<BoxShadow>[
                          BoxShadow(blurRadius: 2.0,
                              color:Colors.grey[400] ,
                              offset: Offset(0.5,0.5))

                        ],
                        shape: BoxShape.rectangle,
                        color: Colors.white ,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child:Container(
                        margin: EdgeInsets.fromLTRB(50, 16, 0, 0),
                        child: Text("prateekmewara@gmail.com")),
                  ),Positioned(
                    left:55,
                    top: 10,
                    child: Container(
                      height:30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape:BoxShape.circle,
                        color:red,
                      ),
                      child:Center(child: Text((index+1).toString(),style: TextStyle(color:white,fontWeight: FontWeight.w500,fontSize: 16),)),
                    ),
                  )

                  ]):index==2?Stack(children: <Widget>[Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width-100,
                    margin: EdgeInsets.only(left:70,right: 32,bottom: 32),
                    decoration: BoxDecoration(
                        boxShadow:<BoxShadow>[
                          BoxShadow(blurRadius: 2.0,
                              color:Colors.grey[400] ,
                              offset: Offset(0.5,0.5))

                        ],
                        shape: BoxShape.rectangle,
                        color: Colors.white ,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child:Container(
                        margin: EdgeInsets.fromLTRB(50, 16, 0, 0),
                        child: Text("prateekmewara@gmail.com")),
                  ),Positioned(
                    left:55,
                    top: 10,
                    child: Container(
                      height:30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape:BoxShape.circle,
                        color:green,
                      ),
                      child:Center(child: Text((index+1).toString(),style: TextStyle(color:white,fontWeight: FontWeight.w500,fontSize: 16),)),
                    ),
                  )

                  ]):Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width-100,
                      margin: EdgeInsets.only(left:50,right: 32,bottom: 32),
                      decoration: BoxDecoration(
                          boxShadow:<BoxShadow>[
                            BoxShadow(blurRadius: 2.0,
                                color:Colors.grey[400] ,
                                offset: Offset(0.5,0.5))

                          ],
                          shape: BoxShape.rectangle,
                          color: Colors.white ,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child:Container(
                          margin: EdgeInsets.fromLTRB(50, 16, 0, 0),
                          child: Text("prateekmewara@gmail.com")),
                      )
                   ;
                }
            )));
  }
  List<String> data=["Registraion","Inaugration","Dinner","Speaker","Speaker","Hack begins","Snacks","Break","Review 1","Speaker","Lunch","Hack","Snacks","Review 2","Hack","Dinner","Hack","Snacks","Pitch","Prze Distribution"];
  List<String> time=["7:00","Inaugration","Dinner","Speaker","Speaker","Hack begins","Snacks","Break","Review 1","Speaker","Lunch","Hack","Snacks","Review 2","Hack","Dinner","Hack","Snacks","Pitch","Prze Distribution"];
int count=0;
  List<Color> colorsDialog=[Colors.yellow[600],Colors.blue,Colors.green,Colors.red];
  Widget DayOne(){
    return Scaffold(
        backgroundColor: background,
        body:SingleChildScrollView(

        child:Container(
      child: Column(
        children: <Widget>[
         Center(child: Container(
           margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
            height: 3,
              width: MediaQuery.of(context).size.width-100,
              child:
          Row(
            children: <Widget>[
Container(
  height: 3,
  width: ((MediaQuery.of(context).size.width-100)/8)*count,
  color: Colors.blue,
  child: Text(" "),
),
              Container(
                height: 2,
                width: ((MediaQuery.of(context).size.width-100)/8)*(8-count),
                color: Colors.grey,
                child: Text(" "),
              )
            ],
          ))),
          Container(
            margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
            padding: EdgeInsets.only(left: 50),
            alignment: Alignment(-1, 0),
            child: Text("$count out of 8",style: TextStyle(fontWeight: FontWeight.w500),),
          ),

          Container(
            height: double.parse((115*8).toString()),
            child: ListView.builder(
                itemCount: 8,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context,int index){
              return count>index?Container(
margin: EdgeInsets.fromLTRB(50, 16, 0, 0),
                height: 85,
                child: Row(
                  children: <Widget>[
                    Container(
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape:BoxShape.circle,
                        color:yellow,
                      ),
                      child:Center(child: Text((index+1).toString(),style: TextStyle(color:white,fontWeight: FontWeight.w500,fontSize: 16),)),
                    ),
                    Container(
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            alignment: Alignment(-1,0),
                            child: Text("Jam Jar",style: TextStyle(fontWeight: FontWeight.w500,fontSize:14),),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16,top: 8),
                            alignment: Alignment(-1,0),
                            child: Text("We See you re person of good taste.",style: TextStyle(color: Colors.black,fontSize:12),),
                          ),
                        ],
                      )
                    )
                  ],
                ),
              ):Container(
                  margin: index==0?EdgeInsets.fromLTRB(50, 0, 0, 0):EdgeInsets.fromLTRB(50, 16, 0, 0),
                  height: 85,
                  child: Row(
                  children: <Widget>[
                  Container(
                  height:50,
                  width: 50,
                  decoration: BoxDecoration(
                  shape:BoxShape.circle,
                  color:Colors.grey,
                  ),
                  child:
                  Container(

                  decoration: BoxDecoration(
                  shape:BoxShape.circle,
                  color: background,
                  ),
                  margin: EdgeInsets.all(2),
                  child: Center(child: Text((index+1).toString(),style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w500,fontSize: 16),)),

                  )

                  ),

                  Container(
                  child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Container(
                  margin: EdgeInsets.only(left: 16),
                  alignment: Alignment(-1,0),
                  child: Text("Unlock",style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w500,fontSize:14),),
                  ),

                  ],
                  )
                  )
                  ],
                  ),
                  );

            }),
          ),
//      Container(
//        height: double.parse((115*(8-count)).toString()),
//        child: ListView.builder(
//            itemCount: 8-count,
//            physics: NeverScrollableScrollPhysics(),
//            itemBuilder: (BuildContext context,int index){
//              return Container(
//                margin: index==0?EdgeInsets.fromLTRB(50, 0, 0, 0):EdgeInsets.fromLTRB(50, 16, 0, 0),
//                height: 85,
//                child: Row(
//                  children: <Widget>[
//                    Container(
//                      height:50,
//                      width: 50,
//                      decoration: BoxDecoration(
//                        shape:BoxShape.circle,
//                        color:Colors.grey,
//                      ),
//                      child:
//                      Container(
//
//                        decoration: BoxDecoration(
//                          shape:BoxShape.circle,
//                          color: background,
//                        ),
//                        margin: EdgeInsets.all(2),
//                        child: Center(child: Text((index+1+count).toString(),style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w500,fontSize: 16),)),
//
//                      )
//
//                    ),
//
//                    Container(
//                        child:Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Container(
//                              margin: EdgeInsets.only(left: 16),
//                              alignment: Alignment(-1,0),
//                              child: Text("Unlock",style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w500,fontSize:14),),
//                            ),
//
//                          ],
//                        )
//                    )
//                  ],
//                ),
//              );
//
//            }),
//      )
        ],
      ),
    ))
    );
  }


}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo((size.width/8)+8,size.height);
    path.arcToPoint(Offset((size.width/8),size.height-8), radius: Radius.circular(8));

    path.lineTo(size.width/8, (size.height/3));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}