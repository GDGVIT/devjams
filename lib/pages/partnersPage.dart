
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:DevJams/Presentation/util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:DevJams/models/global.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:DevJams/models/sharedPref.dart';
import 'package:snaplist/snaplist.dart';
import 'package:url_launcher/url_launcher.dart';

class PartnersPage extends StatefulWidget {
  PartnersPage({Key key,this.restaurantID,this.workerID}) : super(key: key);
  final String restaurantID, workerID;

  @override
  _PartnersPageState createState() => _PartnersPageState();
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

class _PartnersPageState extends State<PartnersPage> {
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

  bool pressAttentionP=true;
  bool pressAttentionS=false;
  bool pressAttentionPBorder=true;
  bool pressAttentionSBorder=false;



  void PAction(){
    setState(() {
    pressAttentionP=true;
    pressAttentionPBorder=true;
    pressAttentionS=false;
    pressAttentionSBorder=false;
    
    });
  }

  void SAction(){
    setState(() {
    pressAttentionPBorder=false;
    pressAttentionS=true;
    pressAttentionSBorder=true;
    pressAttentionP=false;

    });
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
  @override
  Widget build(BuildContext context) {

    var flexibleSpaceWidget = new SliverAppBar(
      backgroundColor: background,
      expandedHeight: 80.0,
      elevation: 0,
//      centerTitle: true,
      pinned: true,

    );

    return Scaffold(
      backgroundColor: background,
      body: new DefaultTabController(
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
                          margin: EdgeInsets.only(left: 32,right: 8),
                          child: Text("Speakers", style: TextStyle(fontSize: 26.0),)),),
                      Tab(child:Container(
                        margin: EdgeInsets.only(left: 0,right: 32),
                        child:  Text("Sponsors", style: TextStyle(fontSize: 26.0)),)),

                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body:Container(
              color: background,
              child: new TabBarView(

                children: <Widget>[
                  PromotionsPage(),
//                  CollaboratorsPage(),
                  SponsorsPage(),
                ],
              )),
        ),
      ),
    );

}
List<String> time = ["10:00 pm - 12:00 am","11:30 am - 12:00 pm","12:30 pm - 1:00 pm","11:10 pm - 12:00 am","10:00 pm - 10:35 pm","Shashank Barki", "10:35 pm - 11:10 pm", "10:00pm to 10:45 pm","11:00 am -11:30 am"];
  List<String> gallary = ["Gallery 2","Gallery 1","Gallery 1","Gallery 1","Gallery 1","Gallery 2", "Gallery 1", "Gallery 2","Gallery 1","Gallery 2"];

  List<String> name = ["Sachin Kumar","Nikita Gandhi","Dinesh Shanmugan C","Rohan Mishra","Thiyagaraj T","Shashank Barki", "Ananya", "Ashwini Purohit","Ajay Ravindra"];
List<String> des = ["From chatbots, Voice to building immersive Visual games for Google Assistant","Making handsome deals with ML ⚙","Building Android Apps at Scale","The 180 degree shift - from Engineering to Design","Building Your Developer Roadmap","Quicken your Cloud Journey using Qwiklabs", "Getting most out of Developer Communities","Building a startup as a college student","Succeeding in Software","Automation of Android and iOS builds and publishing them to app stores"];
List<String> company = ["Google Developers Expert", "Google","RedBus","Zomato","Kubric","Manhattan Associates", "WTM","Winuall.com","Crio.Do","Atlassian"];
List<String> img = ["lib/assests/one.png","lib/assests/two.png","lib/assests/three.jpg","lib/assests/four.jpg","lib/assests/five.png","lib/assests/six.JPG","lib/assests/seven.jpeg","lib/assests/eight.jpg","lib/assests/nine.JPG","lib/assests/ten.png"];

Widget PromotionsPage(){
  return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: 9,
          itemBuilder: (BuildContext ctxt, int index) {
      return Container(
        height: 280,
            width: MediaQuery.of(context).size.width-32,
            margin: EdgeInsets.only(left:32,right: 32,bottom: 32),
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
child: Column(
  children: <Widget>[
    Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(16),
          height: 90,
          width: 90,
         color: Colors.black,
         child: Image.asset(img[index])
        ),
        ClipPath(
          clipper: BottomWaveClipper(),
          child: Container(
            height: 60,
            width: ((MediaQuery.of(context).size.width/5)*3)-27,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(8.0),bottomRight: Radius.circular(8.0)),
              color:red,
            ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(gallary[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
              Text(time[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300))
            ],
          ),
          ))
      ],
    ),
    /*Container(
      margin: EdgeInsets.only(left: 16),
      alignment: Alignment(-1,0),
      child: Text("@twitter",style: TextStyle(color: Colors.blue),),
    ),*/
    Container(
      margin: EdgeInsets.only(left: 16,top: 16),
      alignment: Alignment(-1,0),
      child: Text(name[index],style: TextStyle(fontWeight: FontWeight.w500,fontSize:18),),
    )
    ,
    GestureDetector(
        onTap: (){

          if(index==1){
            sendToServer("Cogs-Jam","Tune in to break the cogged-jam!");
          }
        },
        child:Container(
      margin: EdgeInsets.only(left: 16,top: 16),
      alignment: Alignment(-1,0),
      child: Text(des[index],style: TextStyle(fontWeight: FontWeight.w400,fontSize:14),),
    )),
    Container(
        margin: EdgeInsets.only(left: 16,top: 16,right: 16),
        child:
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(

              height:15,
              width: 15,
//                              height: 20,
//                    width: (MediaQuery.of(context).size.width/10),
              decoration: BoxDecoration(
                shape:BoxShape.circle,
                color:yellow,
              ),
              child: Text(" "),),
            Padding(padding: EdgeInsets.only(left: 3),),
            Text("Technical",style: TextStyle(color: yellow))
          ],
        ),

        Container(
          child: Text(company[index]),
        )

      ],
    ))
  ],
),
      )
      ) ;
  }
));
}
List<String> sponsor=["lib/assests/ATKT.png",
    "lib/assests/Balsamiq.png",
    "lib/assests/CreativeTim.png",
    "lib/assests/Crio.Do.png",
    "lib/assests/Hackerearth.png",
    "lib/assests/Hasura.png",
    "lib/assests/indico.io.png",
    "lib/assests/LBRY.io.png",
    "lib/assests/Overleaf.png",
    "lib/assests/TheSouledStore.png",
    "lib/assests/Zeit.png",
    "lib/assests/Zeplin.png",
    "lib/assests/Zulip.png"];
  List<String> website=["https://atkt.in",
    "https://balsamiq.com",
    "https://www.creative-tim.com",
    "https://crio.do",
    "https://www.hackerearth.com",
    "https://hasura.io",
    "https://indico.io",
    "https://lbry.com",
    "https://www.overleaf.com",
    "https://www.thesouledstore.com" ,
    "https://zeit.co",
    "https://zeplin.io",
    "https://zulipchat.com"];
  Widget SponsorsPage(){
    int i=0;
    ScrollController _scrollController = new ScrollController();
    return Container(
height: MediaQuery.of(context).size.height-300,
        color: background,
//        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
        width: MediaQuery.of(context).size.width,
    child:Column(children: <Widget>[
Container(
  height: 500,
//height: (MediaQuery.of(context).size.width/4)*3,
//  height: (MediaQuery.of(context).size.width/4)*3,
  child:
  ListView.builder(
      itemCount: sponsor.length,
      physics: NeverScrollableScrollPhysics(),
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext ctxt, int index){

      return  Center(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[





                        Container(
                            // color: Colors.white,
                              margin: EdgeInsets.all(MediaQuery.of(context).size.width/8),
                              width: (MediaQuery.of(context).size.width/4)*3,
                              height: (MediaQuery.of(context).size.width/4)*3,
                              padding: EdgeInsets.all(32.0),
                              decoration: BoxDecoration(
                                  boxShadow:<BoxShadow>[
                                    BoxShadow(blurRadius: 2.0,
                                        color:Colors.grey[400] ,
                                        offset: Offset(0.5,0.5))

                                  ],
                                  shape: BoxShape.rectangle,
                                  color: Colors.white ,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
//                                  SvgPicture.asset(sponsor[index], semanticsLabel: "Logo",width: (MediaQuery.of(context).size.width/2)-32, height: 100.0),
                                  Image.asset(sponsor[index] , width: (MediaQuery.of(context).size.width/2)-32, height: 100.0,),
                                ],
                              )),



       ]));}

   ),

),
      Container(child:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(icon: Icon(Icons.arrow_back,size: 36,color:yellow),onPressed: (){
            setState(() {
              if(i>0) {
                i = i - 1;
              }
             _scrollController.animateTo(_scrollController.position.pixels-MediaQuery.of(context).size.width, duration: new Duration(seconds: 1), curve: Curves.ease);
//              _isVisible=false;
            });

          },),
         GestureDetector(
             onTap: (){

               _launchURL(website[i]);
             },

             child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape:BoxShape.circle,
                color:yellow,
              ),
              child:
              IconButton(icon: Icon(Icons.share,size: 36,color: Colors.white,),))),
          IconButton(icon: Icon(Icons.arrow_forward,size: 36,color:yellow,),onPressed: (){
    setState(() {
      if(i<sponsor.length) {
        i = i + 1;
      }
    _scrollController.animateTo(_scrollController.position.pixels+MediaQuery.of(context).size.width, duration: new Duration(seconds: 1), curve: Curves.ease);
//              _isVisible=false;
    });

    })
        ],
      ))
    ]));


  }
  _launchURL(String val) async {
    var url = val;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

Widget CollaboratorsPage(){
  return Container(
      width: MediaQuery.of(context).size.width,
      child : LayoutBuilder(

      builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        padding: EdgeInsets.only(bottom:20.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap : (){

              },
              child : Container(
                // color: Colors.white,
                  margin: EdgeInsets.all(12),
                  width: (MediaQuery.of(context).size.width/4)*3,
                  height: (MediaQuery.of(context).size.width/4)*3,
                  padding: EdgeInsets.only(top: 10.0),
                  decoration: BoxDecoration(
                      boxShadow:<BoxShadow>[
                        BoxShadow(blurRadius:2.0,
                            color:Colors.grey[400] ,
                            offset: Offset(0.5,0.5))

                      ],
                      shape: BoxShape.rectangle,
                      color: Colors.white ,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('lib/assests/tekno.png' , width: (MediaQuery.of(context).size.width/2)-32, height: 100.0,),
                    ],
                  )),),
            Container(
                // color: Colors.white,
                  margin: EdgeInsets.all(12),
                  width: (MediaQuery.of(context).size.width/4)*3,
                  height:(MediaQuery.of(context).size.width/4)*3,
                  padding: EdgeInsets.only(top: 10.0),
                  decoration: BoxDecoration(
                      boxShadow:<BoxShadow>[
                        BoxShadow(blurRadius: 2.0,
                            color:Colors.grey[400] ,
                            offset: Offset(0.5,0.5))

                      ],
                      shape: BoxShape.rectangle,
                      color: Colors.white ,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('lib/assests/yourstory.png' , width: (MediaQuery.of(context).size.width/2)-32, height: 100.0,),
                    ],
                  )),
            GestureDetector(
              onTap : (){

              },
              child : Container(
                // color: Colors.white,
                  margin: EdgeInsets.all(12),
                  width: (MediaQuery.of(context).size.width/4)*3,
                  height: (MediaQuery.of(context).size.width/4)*3,
                  padding: EdgeInsets.only(top: 10.0),
                  decoration: BoxDecoration(
                      boxShadow:<BoxShadow>[
                        BoxShadow(blurRadius: 2.0,
                            color:Colors.grey[400] ,
                            offset: Offset(0.5,0.5))

                      ],
                      shape: BoxShape.rectangle,
                      color: Colors.white ,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('lib/assests/reliance.png' , width: (MediaQuery.of(context).size.width/2)-32, height: 100.0,),
                    ],
                  )),),
            
            GestureDetector(
              onTap : (){

              },
              child : Container(
                // color: Colors.white,
                  margin: EdgeInsets.all(12),
                  width: (MediaQuery.of(context).size.width/4)*3,
                  height:(MediaQuery.of(context).size.width/4)*3,
                  padding: EdgeInsets.only(top: 10.0),
                  decoration: BoxDecoration(
                      boxShadow:<BoxShadow>[
                        BoxShadow(blurRadius: 2.0,
                            color:Colors.grey[400] ,
                            offset: Offset(0.5,0.5))

                      ],
                      shape: BoxShape.rectangle,
                      color: Colors.white ,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('lib/assests/edtimes.png' , width: (MediaQuery.of(context).size.width/2)-32, height: 100.0,),
                    ],
                  )),),
        Container(
                // color: Colors.white,
                  margin: EdgeInsets.all(12),
                  width: (MediaQuery.of(context).size.width/4)*3,
                  height:(MediaQuery.of(context).size.width/4)*3,
                  padding: EdgeInsets.only(top: 10.0),
                  decoration: BoxDecoration(
                      boxShadow:<BoxShadow>[
                        BoxShadow(blurRadius: 2.0,
                            color:Colors.grey[400] ,
                            offset: Offset(0.5,0.5))

                      ],
                      shape: BoxShape.rectangle,
                      color: Colors.white ,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('lib/assests/tbi.png' , width: (MediaQuery.of(context).size.width/2)-32, height: 100.0,),
                    ],
                  )),
                   
            ],),
        )
    );
  }
));
}

  Map<String , dynamic> body={
    "name":"",
    "description":""
  };
  sendToServer(String name,String des){


    body["name"]='$name';
    body["description"]='$des';

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
//          Fluttertoast.showToast(
//              msg: "Try Again",
//              toastLength: Toast.LENGTH_SHORT,
//              gravity: ToastGravity.BOTTOM,
//              timeInSecForIos: 1,
//              backgroundColor: Colors.grey[700],
//              textColor: Colors.white);
        }
        else {
//          Fluttertoast.showToast(
//              msg: "Try Again",
//              toastLength: Toast.LENGTH_SHORT,
//              gravity: ToastGravity.BOTTOM,
//              timeInSecForIos: 1,
//              backgroundColor: Colors.grey[700],
//              textColor: Colors.white);
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

//        Fluttertoast.showToast(
//            msg: "Try Again",
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.BOTTOM,
//            timeInSecForIos: 1,
//            backgroundColor: Colors.grey[700],
//            textColor: Colors.white);
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
    path.lineTo((size.width/8)+8,size.height);
    path.arcToPoint(Offset((size.width/8),size.height-8), radius: Radius.circular(8));

    path.lineTo(size.width/8, (size.height/3));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}