class Logincl{
  List<String> teamMates;
  String email;
  Logincl({this.email,this.teamMates});

  factory Logincl.fromJson(Map<String,dynamic> json){
    var emailFromJson  = json["teamMates"];
    List<String> emailList = new List<String>.from(emailFromJson);
    return Logincl(
      teamMates: emailList,
      email: json["email"]
    );
  }

}