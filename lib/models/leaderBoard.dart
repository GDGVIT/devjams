import 'package:flutter/material.dart';

class LeaderBoard{
  int jamsCollected;
  String email;
  LeaderBoard({this.email,this.jamsCollected});
  factory LeaderBoard.fromJson(Map<String,dynamic> json){
    return LeaderBoard(
        email: json["email"],
        jamsCollected: json["jams_collected"]
    );
  }
}