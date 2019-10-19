// import 'package:intro_slider/intro_slider.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:qrcode_reader/qrcode_reader.dart';
// import 'package:vit_hack/pages/loginScreen.dart';

// class SliderScreen extends StatefulWidget {
//   @override
//   _SliderScreenState createState() => _SliderScreenState();
// }

// class _SliderScreenState extends State<SliderScreen> {
//   List<Slide> slides = new List();

//   @override
//   void initState() {
//     super.initState();

//     slides.add(
//       new Slide(
//         title: "Welcome to VIT HACK",
//         description: "Some description",
//        // pathImage: "images/photo_eraser.png",
//         backgroundColor: Colors.white,
//       ),
//     );
//     slides.add(
//       new Slide(
//         title: "Welcome to VIT HACK",
//         description: "Some description",
//        // pathImage: "images/photo_eraser.png",
//         backgroundColor: Colors.white,
//       ),
//     );
//     slides.add(
//       new Slide(
//         title: "Welcome to VIT HACK",
//         description: "Some description",
//        // pathImage: "images/photo_eraser.png",
//         backgroundColor: Colors.white,
//       ),
//     );
//   }

//   void onDonePress() {
//     Navigator.push(
//                   context,
//                   new MaterialPageRoute(
//                       builder: (BuildContext context) =>
//                       new LoginScreen()));
//   }

//   void onSkipPress() {
//     Navigator.push(
//                   context,
//                   new MaterialPageRoute(
//                       builder: (BuildContext context) =>
//                       new LoginScreen()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new IntroSlider(
//       slides: this.slides,
//       onDonePress: this.onDonePress,
//       onSkipPress: this.onSkipPress,
//     );
//   }
// }