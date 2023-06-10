// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training1/logg/CreatAccount.dart';
import 'package:training1/logg/hompage.dart';
import 'package:training1/logg/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:training1/pages/aboutas.dart';
import 'package:training1/pages/addrequest.dart';
import 'package:training1/pages/page2/page22.dart';
import 'package:training1/pages/page33/calendar_tile.dart';
bool islog=false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user=await FirebaseAuth.instance.currentUser;
  if(user==null){islog=false;}
  else{islog=true;};
  await Firebase.initializeApp();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green,),
      routes: {
       "login" : (context)=>Login(),
        "home":(context) => Homepage(),
        'creat':(context)=>const CreatA(),
        'request':(context)=>addReq(),
        'page3':(context)=>requests(),
        'calender':(context) => page2(),
      'about':(context) =>Aboutus(),
      },
      home: islog==false?Login():Homepage(),
    );
  }
}

