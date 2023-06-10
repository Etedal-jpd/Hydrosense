// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:training1/pages/addrequest.dart';
import 'package:http/http.dart' as http;

class requests extends StatefulWidget {
  const requests({super.key});

  @override
  State<requests> createState() => _requestsState();
}

class _requestsState extends State<requests> {
List user=[];
String title="";
String notification1="";
String notification2="";


List us22=[];

retrievedus22() async {
  try {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users").child(userId);
    var snapshot = await userRef.get();
    if (snapshot.exists) {
      setState(() {
        us22.add(snapshot.value as Map<dynamic, dynamic>);
      });

      Notificationfun();
      print("Data retrieved successfully");
    }
  } catch (error) {
    print("Error retrieving data: $error");
  }
}
  @override
  void initState() {
    super.initState();
   retrieved();
   retrievedus();
    retrievedus22();
  }
Notificationfun() async {
  if (us.isNotEmpty && us[0]["Nutrient-tank"] != null && us[0]["Nutrient-tank"] <= 30) {
    title = "Wrong";
    notification1 = "Amount of water in the Nutrient Tank is less than 20%. Please fill the tank";
  }
  if (us.isNotEmpty && us[0]["main-tank"] != null && us[0]["main-tank"] <= 30) {
    title = "Wrong";
    notification2 = "Amount of water in the Main Tank is less than 20%. Please fill the tank";
  }

  getMessagetoupdate(title, notification1, notification2);
}

  Future<void> getMessagetoupdate(t,n1,n2) async {
    //FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users").child(userId).child("notification");
   await userRef.update({
        "title": t,
        "body1": n1,
        "body2":n2,
      });
        retrieved();
        print('Data updated successfully');
      } catch (e) {
        print('Error updating data: $e');
      }
    
  }



 retrieved() async {
  try {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    // ignore: deprecated_member_use
    DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users").child(userId).child("notification");
    var snapshot = await userRef.get();
    if (snapshot.exists) {
      setState(() {
        userRef.onValue.listen((DatabaseEvent event) {
        user.add(event.snapshot.value);

        });
      });
      print("Data retrieved successfully");
    }
  } catch (error) {
    print("Error retrieving data: $error");
  }
}
List us=[];
retrievedus() async {
  try {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users").child(userId).child("data");
    var snapshot = await userRef.get();
    if (snapshot.exists) {
      setState(() {
        us.add(snapshot.value as Map<dynamic, dynamic>);
        Notificationfun();
      });
      print("Data retrieved successfully");

    }
  } catch (error) {
    print("Error retrieving data: $error");
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 195, 228, 196),
  drawer: Drawer(// ignore: prefer_const_literals_to_create_immutables
            backgroundColor:Colors.white,
            surfaceTintColor:Colors.green,
           child: Column(children: [
            UserAccountsDrawerHeader(
              accountName: us22.isEmpty ||us22==null?Text("loading"): Text("${us22[0]["name"]}",style: TextStyle( fontSize:18.0,)),
              accountEmail: us22.isEmpty ||us22==null?Text("loading"): Text("${us22[0]["email"]}",style: TextStyle( fontSize:18.0,)) ),
             ListTile( title: Text("Home page"),leading:Icon(Icons.home),onTap: () {Navigator.of(context).pushNamed("home");},),ListTile(title: Text("About"),leading:Icon(Icons.search),onTap: () {},),ListTile(title: Text("Help"),leading:Icon(Icons.help),onTap: () { Navigator.of(context).pushNamed("request");},),ListTile(title: Text("log out"),leading:Icon(Icons.logout),onTap: () {Navigator.of(context).pushNamed("login");},),
            ],
           ),
 ),
  appBar: AppBar(elevation: 0, backgroundColor:Color.fromARGB(255, 30, 82, 30),automaticallyImplyLeading: false,
          title: const Center(child:Text("notification",style: TextStyle(color:Colors.white),)),leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.menu,color:Colors.white),
        onPressed: () { Scaffold.of(context).openDrawer(); },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    },
  ),
           actions: [
            Container(height: 40,width:40,
            margin: const EdgeInsets.only(right: 20, top: 10, bottom: 5),
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
               color:    Color.fromARGB(255, 219, 236, 213),
               boxShadow: [const BoxShadow(color: Color.fromARGB(255, 59, 164, 63),blurRadius:5,offset: Offset(0, 0))] ,
               borderRadius: BorderRadius.circular(10),
               image: const DecorationImage(scale:0.02 ,image: AssetImage("images/asset/11preview.png")),
            ),
           
           )
            
             ],),
  body: Container(child: Column(
        children: [
         Row(
          crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Container(
              padding: EdgeInsets.only(top:30),
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(DateFormat.yMMMMd().format(DateTime.now()),style: TextStyle(fontSize: 25),),Text("Today",style: TextStyle(fontSize: 20,height: 2),)]),
                      
                      ),
             Container(padding: EdgeInsets.only(left:50,top: 25),
                child: GestureDetector(
                excludeFromSemantics: Get.testMode = true,
                onTap:()=> Navigator.of(context).pushNamed("request"),
                child: Container(padding: EdgeInsets.only(top:20,left: 10),
                        width: 120,height: 60,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Color.fromARGB(255, 30, 82, 30)),
                        child:Text("+ Add Request",style: TextStyle(color: Colors.white),) ,)),
              )
                  
           ],
         ),
         SizedBox (height:50.0,),
          user.isEmpty || user==null || user[0]["body1"]==""?Text(""):
          Column(
        children: [
           Container(
            width:600,
            margin: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 5),
             decoration: BoxDecoration( 
             borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient (colors: [Color.fromARGB(255, 133, 220, 136),Color.fromARGB(255, 148, 202, 148)],
            begin:FractionalOffset (0.5,1)) // LinearGradient
          ),
             child: Column(
               children: [
                 Container(padding: EdgeInsets.all(10),
                   child: Row(
                     children: [
                       Icon(Icons.error,color: Colors.amber,), user.isEmpty ||user==null?Text("..."): Text("   ${user[0]["title"]}",style: TextStyle( fontSize:20.0,)),
                     ],
                     
                   ),
                 ),
              
               Container(padding: EdgeInsets.only(left: 10,bottom: 10),
                   margin: EdgeInsets.only(left: 7),
                   child: user.isEmpty ||user==null?Text("..."): Text("${user[0]["body1"]}",style: TextStyle( fontSize:18.0,)))
                       , SizedBox (height:10,)
               
               ]))
          ,
 

        ],
      ), SizedBox (height:5),

user.isEmpty || user==null || user[0]["body2"]==""?Text(""):
          Column(
            children: [
              Container(
                  width:600,
                  margin: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient (colors: [Color.fromARGB(255, 133, 220, 136),Color.fromARGB(255, 148, 202, 148)],
                          begin:FractionalOffset (0.5,1)) // LinearGradient
                  ),
                  child: Column(
                      children: [
                        Container(padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.error,color: Colors.amber,), user.isEmpty ||user==null?Text("..."): Text("   ${user[0]["title"]}",style: TextStyle( fontSize:20.0,)),
                            ],

                          ),
                        ),

                        Container(padding: EdgeInsets.only(left: 10,bottom: 10),
                            margin: EdgeInsets.only(left: 7),
                            child: user.isEmpty ||user==null?Text("..."): Text("${user[0]["body2"]}",style: TextStyle( fontSize:18.0,)))
                        , SizedBox (height:10,)

                      ]))
              ,


            ],
          ),
         ]
),),
    );
  }
}