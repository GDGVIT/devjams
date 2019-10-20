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

class ContactUsPage extends StatefulWidget {
  ContactUsPage({Key key,}) : super(key: key);

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

class _HomePageState extends State<ContactUsPage> with TickerProviderStateMixin {

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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
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
                                  child: Text("Profile", style: TextStyle(fontSize: 26.0,fontWeight: FontWeight.w500),)),),
                              Tab(child:Container(
//                        color:background,
                                margin: EdgeInsets.only(left: 0,right: 32),
                                child:  Text("DSC Team", style: TextStyle(fontSize: 26.0)),)),
                            ],
                          ),
                        ),
                        pinned: true,
                      ),
                    ];
                  },
                  body:SingleChildScrollView(
                    child:  Container(
                        height: MediaQuery.of(context).size.height,
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

List<String> name = ["Samarth Nayyar","Ayush Priya","Samyak Jain","Dhiraj Jain","Abhishek Kaushik","Apurva Nitanjay", "Preethi G", "Yaswant Narayan","Paritosh Mahajan","Vikrame Vasudev", "Angad Sharma", "Ubaid Usmani", "Prateek Mewara","Satkriti Singh", "Amogh Lele", "Nikhil Singh", "Purushottam Sharma","Ananya Ganesh","Riddhi Gupta","Abhishek Kushwaha","Vishaal Selvaraj","Deepak Malpani","Meherdeep Thakur", "Hardik Kataria","Deepak Nahar","Sanchi Chopra","Dhruv Mittal","Vivek Shetty","Akshat Gupta","Shubham Srivastava","Muskan Rastogi","Kritika Sharma","Naynika Wason","Shreya Maheshwari","Saloni Parekh","Manorama Maharana","Arjun Bhanot","Cyril Peter","Ekaansh Arora", "Riya Kanabar","Ruchica Sinha","Adity Rathore","Shravani Shete"];
List<String> des = ["Community Lead","Technical Lead", "Technical Lead","Technical Advisor","Android Lead","Projects Lead","PR Lead", "Android","ML", "Web","Backend","ML","Android","Android","Android","Web","Web","Web"," Backend","Backend","Algorithms","ML","Manager","Manager", "Content","Content","Manager","Manager","Manager","Manager","Manager","Manager","Content","Content","Content","Manager","Manager","Manager","UI/UX","Graphic","Graphic","3D & Motion","Graphic"];
List<String> field = ["", "","","","","","","Technical","Technical","Technical","Technical","Technical","Technical","Technical","Technical","Technical","Technical","Technical","Technical","Technical","Technical","Technical","Management","Management","Management","Management","Management","Management","Management","Management","Management","Management","Management","Management","Management","Management","Management","Management", "Design","Design", "Design", "Design", "Design"];
List<String> img = ["lib/assests/Samarth.jpg","lib/assests/Ayush.jpg","lib/assests/Samyak.jpg","lib/assests/Dhiraj.jpeg","lib/assests/Abhishek.jpg","lib/assests/Apoorva.jpg","lib/assests/preethi.JPG"
,"lib/assests/Yaswant.JPG","lib/assests/Paritosh.jpg","lib/assests/Vikrame.jpg","lib/assests/Angad.jpeg","lib/assests/Ubaid.jpg","lib/assests/Prateek.png","lib/assests/Satkriti.jpg","lib/assests/Amogh.jpg","lib/assests/Nikhil.jpeg","lib/assests/Purushottam.jpeg","lib/assests/Ananya.jpg","lib/assests/Riddhi.JPG","lib/assests/Abhi.jpg","lib/assests/Vishaal.jpg","lib/assests/DeepakT.jpg","lib/assests/Cyril.jpg"
,"lib/assests/Meher.JPG","lib/assests/Hardik.JPEG","lib/assests/DeepakM.jpeg","lib/assests/Sanchi.jpeg","lib/assests/Dhruv.jpg","lib/assests/Vivek.jpg","lib/assests/Akshat.jpeg","lib/assests/Shubham.jpg","lib/assests/Muskan.jpg","lib/assests/Kritika.JPG","lib/assests/Naynika.jpeg","lib/assests/Shreya.jpeg","lib/assests/Saloni.jpg","lib/assests/Manorama.jpg","lib/assests/Arjun.jpeg"
,"lib/assests/Ekaansh.jpeg","lib/assests/Riya.jpg","lib/assests/Ruchika.jpeg","lib/assests/Aditya.jpg","lib/assests/Shravani.jpg"];

  Widget DayTwo(){
    return Scaffold(
//<<<<<<< HEAD
//        body:Container(
//        width: MediaQuery.of(context).size.width,
//    child: ListView.builder(
//    itemCount: 10,
//    itemBuilder: (BuildContext ctxt, int index) {
//    return Container(
//    height: 200,
//    width: MediaQuery.of(context).size.width-32,
//    margin: EdgeInsets.only(left:32,right: 32,bottom: 32),
//    decoration: BoxDecoration(
//    boxShadow:<BoxShadow>[
//    BoxShadow(blurRadius: 2.0,
//    color:Colors.grey[400] ,
//    offset: Offset(0.5,0.5))
//
//    ],
//    shape: BoxShape.rectangle,
//    color: Colors.white ,
//    borderRadius: BorderRadius.all(Radius.circular(5))),
//    child:Container(
//    child: Column(
//    children: <Widget>[
//=======
        body: SingleChildScrollView( 
          child : Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height-200,
      child: ListView.builder(
          itemCount: img.length,
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
//>>>>>>> 18db13cbfccb2e0e10d470a17c5d62417ff2e6a2
    Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(16),
          height: 90,
          width: 90,
         color: Colors.black,
         child: Image.asset(img[index])
        ),
        /*ClipPath(
          clipper: BottomWaveClipper(),
          child: Container(
            height: 60,
            width: (MediaQuery.of(context).size.width/5)*2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(8.0),bottomRight: Radius.circular(8.0)),
              color:Colors.red,
            ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Gallery 1",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
              Text("1 pm to 2 pm",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300))
            ],
          ),
          ))*/
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
    ),
    Container(
      margin: EdgeInsets.only(left: 16,top: 16),
      alignment: Alignment(-1,0),
      child: Text(des[index],style: TextStyle(fontWeight: FontWeight.w400,fontSize:14),),
    ),
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
                color:getColor(field[index]),
              ),
              child: Text(" "),),
            Padding(padding: EdgeInsets.only(left: 3),),
            Text(field[index],style: TextStyle(color: getColor(field[index])))
          ],
        ),

//<<<<<<< HEAD
//    Container(
//      width: 60,
//    child: Image.asset("lib/assests/DSCVITLogo.png"),
//    )
//=======
//        Container(
//          child: Text("DSC VIT"),
//        )
//>>>>>>> 18db13cbfccb2e0e10d470a17c5d62417ff2e6a2

      ],
    ))
  ],
),
      )
      ) ;
  }
))));
  }
  List<String> data=["Registraion","Inaugration","Dinner","Speaker","Speaker","Hack begins","Snacks","Break","Review 1","Speaker","Lunch","Hack","Snacks","Review 2","Hack","Dinner","Hack","Snacks","Pitch","Prize Distribution"];
  List<String> time=["7:00","Inaugration","Dinner","Speaker","Speaker","Hack begins","Snacks","Break","Review 1","Speaker","Lunch","Hack","Snacks","Review 2","Hack","Dinner","Hack","Snacks","Pitch","Prize Distribution"];

  List<Color> colorsDialog=[Colors.yellow[600],Colors.blue,Colors.green,Colors.red];
  Widget DayOne(){
    return Scaffold(
      body:
    Container(
    child:Column(
      children: <Widget>[

        Container(
          padding: EdgeInsets.fromLTRB(50, 40, 16, 0),
          alignment:Alignment(-1, 0) ,
          child: Text("Email",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(50, 16, 16, 0),
          alignment:Alignment(-1, 0) ,
          child: Text(email),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(50, 40, 16, 0),
          alignment:Alignment(-1, 0) ,
          child: Text("QR Code",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
        ),

        Container(
            padding: EdgeInsets.fromLTRB(40, 16, 16, 0),
            alignment:Alignment(-1, 0) ,
        child:QrImage(
          data: email,
          //version: 3,
          size: 200.0,
        )
        ),
GestureDetector(
  onTap: (){

    logOut();
  },
  child:
Container(
    height: 60,
    width: MediaQuery.of(context).size.width-100,
    margin: EdgeInsets.only(left:32,right: 32,top: 32),
    decoration: BoxDecoration(
        boxShadow:<BoxShadow>[
          BoxShadow(blurRadius: 2.0,
              color:Colors.grey[400] ,
              offset: Offset(0.5,0.5))

        ],
        shape: BoxShape.rectangle,
        color: red,
        borderRadius: BorderRadius.all(Radius.circular(5))),
    child:Center(child:Text("Logout",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),))
))
      ],
    )

    )
    );
  }

  Color getColor(String s){
    if(s==""){
      return Colors.white;
    }
    else if(s=="Design"){
      return Colors.red;
    }
    else if(s=="Management"){
      return Colors.green;
    }
    else if(s=="Technical"){
      return Colors.yellow;
    }
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

