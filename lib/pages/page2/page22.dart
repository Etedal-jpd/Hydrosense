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
 var serverToken = "AAAAcJSyk-A:APA91bFY7fopJoBcRjmrTtlSQg_ewFFKjA0t4wZ7jj7cLNvgiTDIK4ghTSKC_qytQxBpF81vgRbDHFNogiD2WgsD46SziFyLRNTQYHCauDRLJI5Lm5qo-ZQmUj6VJDteA5YVtyy1vmEY";

  @override
  void initState() {
    super.initState();
   Notification();
retrieved();
    getMessagetoupdate();
  }
Notification()async{
await sendNotification("Wrong", "Amount of water in the tank is  less than 20%.", "id");

}


  Future<void> sendNotification(String title, String body, String id) async {
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final headers = <String, String>{
      "Content-Type": 'application/json',
      "Authorization": 'key=$serverToken',
    };
    final message = {
      'notification': {
        'body': body.toString(),
        'title': title.toString(),
      },
      'priority': 'high',
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      },
      'to': await FirebaseMessaging.instance.getToken(),
    };

    final response = await http.post(url, headers: headers, body: jsonEncode(message));

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Error: ${response.body}');
    }
  }



  void getMessagetoupdate() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users").child(userId).child("notification");
   await userRef.update({
        "title": message.notification?.title,
        "body": message.notification?.body,
      });
        retrieved();
        print('Data updated successfully');
      } catch (e) {
        print('Error updating data: $e');
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 195, 228, 196),
  drawer: Drawer(// ignore: prefer_const_literals_to_create_immutables
            backgroundColor:Colors.white,
            surfaceTintColor:Colors.green,
           child: Column(children: [
            UserAccountsDrawerHeader(
              accountName: user.isEmpty ||user==null?Text("loading"): Text("${user[0]["name"]}",style: TextStyle( fontSize:18.0,)), 
              accountEmail: user.isEmpty ||user==null?Text("loading"): Text("${user[0]["email"]}",style: TextStyle( fontSize:18.0,)) ),
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
            Container(height: 40,width: 40,
            margin: const EdgeInsets.only(right: 20, top: 10, bottom: 5),
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
               color:    Color.fromARGB(255, 219, 236, 213),
               boxShadow: [const BoxShadow(color: Color.fromARGB(255, 59, 164, 63),blurRadius: 10,offset: Offset(0, 0))] ,   
               borderRadius: BorderRadius.circular(10),
               image: const DecorationImage( fit: BoxFit.fill,image: AssetImage("images/asset/logo-512x512-1.png"))
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
         Column(
        children: [
           Container(
            width:600,
            margin: EdgeInsets.all(20),
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
              
               Container(padding: EdgeInsets.only(left: 10,bottom: 10),child: user.isEmpty ||user==null?Text("..."): Text("${user[0]["body"]}",style: TextStyle( fontSize:18.0,)))]))

        ],
      ),
         ]
),),
    );
  }
}