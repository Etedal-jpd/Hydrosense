// ignore_for_file: prefer_const_literals_to_create_immutables, unused_import, prefer_const_constructors, camel_case_types, override_on_non_overriding_member, library_private_types_in_public_api, unused_local_variable, deprecated_member_use
import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:training1/pages/addrequest.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';
class page2 extends StatefulWidget {
  const page2({super.key});

  @override
  State<page2> createState() => _page2State();
}

class _page2State extends State<page2> {
  GlobalKey<FormState>_formKey = GlobalKey<FormState> ();
  double percent=0;
  String Timeleft="";
  String futureDate="";
  String start="";
DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  late Timer timer;
_ss() {
  if (user[0]["finishd"] != null) {
    if (user[0]["finishd"] is String && user[0]["finishd"].isNotEmpty) {
      final dateFormatter = DateFormat('dd MMM,yy');
      final currentDate = DateTime.now();
      final finishDate = dateFormatter.parse(user[0]["finishd"]);
      final difference = finishDate.difference(currentDate);
      Timeleft = difference.inDays.toString();
      print("Days: ${difference.inDays}");
    } else if (user[0]["finishd"] is int) {
      final currentDate = DateTime.now();
      final finishDate = DateTime.fromMillisecondsSinceEpoch(user[0]["finishd"]);
      final difference = finishDate.difference(currentDate);
      Timeleft = difference.inDays.toString();
      print("Days: ${difference.inDays}");
    }
  }

  futureDate = DateFormat('dd MMM,yy').format(DateTime.now().add(Duration(days: 25))).toString();
  start = DateFormat.yMMMMd().format(DateTime.now());
}

 List user=[];


/*retrieved() async {
  try {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users").child(userId);
    var snapshot = await userRef.get();
    if (snapshot.exists) {
      setState(() {
        user.add(snapshot.value as Map<dynamic, dynamic>);
       _ss();
       updateText();
      });
      print("Data retrieved successfully");
    }
  } catch (error) {
    print("Error retrieving data: $error");
  }
}*/

 retrieved() async{
    String userId = FirebaseAuth.instance.currentUser!.uid;
     DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users").child(userId);
     final snapshot = await userRef.get();
if (snapshot.exists) {
    user.add(snapshot.value);
     _ss();
     updateText();
     print("Data retrieved successfully");
} else {
    print('No data available.');
}

  }

@override
void initState() {
  super.initState();
  retrieved() ;
}


 updat()async{
 try {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users").child(userId);

    await userRef.update({
      "start": start,
      "finishd": futureDate,
    });
    retrieved() ;
    updateText() ;
    print('Data updated successfully');
  } catch (e) {
    print('Error updating data: $e');
  }
}

 bool validatsave() {
    final form =_formKey.currentState;
    form?.save();
      return true;
  }
var s="";var f="";var t="";
void updateText() {
    setState(() {
       s=user[0]["start"];
       f =user[0]["finishd"];
       t=Timeleft;
      // Update the value of 'text'
    });
  }


_StartDate(){
   setState(() {
     futureDate=DateFormat('dd MMM,yy').format(DateTime.now().add(Duration(days: 25))).toString();
     start=DateFormat.yMMMMd().format(DateTime.now());
    validatsave();
    ;});  updat();setState(() {
       retrieved();
    });

}


@override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 195, 228, 196),
  drawer: Drawer(// ignore: prefer_const_literals_to_create_immutables
            backgroundColor:Colors.white,
            surfaceTintColor:Colors.green,
           child: Column(children: [
            UserAccountsDrawerHeader(
              accountName: user.isEmpty ||user==null?Text("..."): Text("${user[0]["name"]}",style: TextStyle( fontSize:18.0,)),
              accountEmail: user.isEmpty ||user==null?Text(""): Text("${user[0]["email"]}",style: TextStyle( fontSize:18.0,)) ),
             ListTile( title: Text("Home page"),leading:Icon(Icons.home),onTap: () {Navigator.of(context).pushNamed("home");},),ListTile(title: Text("About"),leading:Icon(Icons.search),onTap: () {},),ListTile(title: Text("Help"),leading:Icon(Icons.help),onTap: () { Navigator.of(context).pushNamed("request");},),ListTile(title: Text("log out"),leading:Icon(Icons.logout),onTap: () {Navigator.of(context).pushNamed("login");},),
            ],
           ),
 ),
  appBar: AppBar(elevation: 0, backgroundColor:Color.fromARGB(255, 30, 82, 30),automaticallyImplyLeading: false,
          title: const Center(child:Text("harvest",style: TextStyle(color:Colors.white),)),leading: Builder(
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
              image: const DecorationImage(scale:0.02 ,image: AssetImage("images/asset/11preview.png")),
            ),
           
           )
                         ],),
  body: 
   Container(
       decoration: BoxDecoration( 
            gradient: LinearGradient (colors: [Color.fromARGB(255, 86, 182, 89),Color.fromARGB(255, 30, 82, 30)],
            begin:FractionalOffset (0.5,1)) // LinearGradient
          ),// BoxDecoration width: double.infinity,
          child: Column( 
            mainAxisAlignment: MainAxisAlignment .start, crossAxisAlignment: CrossAxisAlignment.center,
             children: [
              Padding( padding: EdgeInsets.only(top: 25.0), 
                child: Text("Days Left to Harvest", 
                style: TextStyle(color: Colors .white, fontSize:25.0))), // Textstyle
              Container( height:270,
                child:CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  percent:percent, 
                  animation: true, 
                  animateFromLastPercent: true, 
                  radius: 120.0,
                  lineWidth: 20.0,
                  progressColor: Color.fromARGB(255, 181, 170, 170),center:user.isEmpty ||user==null?Text(""):  Text("$t",
                  style: TextStyle( color: Colors.white,fontSize:70.0)))),
              SizedBox (height:10.0,),
              Expanded(child: Container ( width: double. infinity,
                decoration: BoxDecoration(color: Color.fromARGB(255, 195, 228, 196),
                borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),topLeft: Radius.circular(30.0)), ),
                child: Padding(
                  padding: EdgeInsets.only(top: 30.0,left: 20.0, right: 20.0),
            child: SingleChildScrollView(
              child:
                   Column( children:[ 
                    Container( height:100,child:
                    Row(children:[
                      Expanded(child: Column(children:[
                        SizedBox (height:10.0,),
                        Text("Start", style: TextStyle( fontSize:25.0,)),
                        SizedBox (height:20.0,),
                        user.isEmpty ||user==null?Text(""): Text("$s",style: TextStyle( fontSize:20,))
                        ])),
                      Expanded(child: Column(children:[
                        SizedBox (height:10.0,),
                        Text("Finish", style: TextStyle( fontSize: 25.0,)),
                        SizedBox (height:10,),
                        user.isEmpty ||user==null?Text(""): Text("$f",style: TextStyle( fontSize:20,))
                        ]))
                      
                        ])),
                        
                    Container(height:130,margin: EdgeInsets.only(top:20),
                      child: Padding(padding: EdgeInsets.symmetric(vertical: 30.0), 
                        child: MaterialButton(
                               onPressed:() async{await _StartDate();Navigator.of(context).pushNamed("home");}
                               ,color: Color.fromARGB(255, 30, 82, 30), 
                               shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular (100.0),), 
                               child: Padding( padding: EdgeInsets.all(20.0), 
                                 child: Text("Lettuce begins to settle", style: TextStyle(color: Colors.white, fontSize: 22.0),  )))),
                    
                    
                    
                    )
                        
                        ])), 


) )
  )]),)

    );
  }
}


  String text = '';

  