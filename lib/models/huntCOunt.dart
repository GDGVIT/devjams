class HuntCount{
int count;
List<Jam> jam;

HuntCount({this.count,this.jam});

factory HuntCount.fromJson(Map<String,dynamic> json){

  var addlist = json["jams"] as List;

  List<Jam> adList = addlist.map((i) => Jam.fromJson(i)).toList();


  return HuntCount(
   count:json["jams_collected"],
    jam: adList

  );
}
}
class Jam{
  String name;
  String description;

  Jam({this.description,this.name});

  factory Jam.fromJson(Map<String,dynamic> json){
    return Jam(
      name: json["name"],
      description: json["description"]
    );
  }
}