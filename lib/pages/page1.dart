// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:training1/pages/clas.dart';

class CurrentWeatherPage extends StatefulWidget {

  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  late Weather _weather;
List user=[];


retrieved() async {
  try {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users").child(userId);
    var snapshot = await userRef.get();
    if (snapshot.exists) {
      setState(() {
        user.add(snapshot.value as Map<dynamic, dynamic>);

      });
      print("Data retrieved successfully");
    }
  } catch (error) {
    print("Error retrieving data: $error");
  }
}
@override
void initState() {
  super.initState();
  setState(() {
    retrieved();
  });

}
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 215, 244, 216),
      drawer: Drawer(// ignore: prefer_const_literals_to_create_immutables
            backgroundColor:Colors.white,
            surfaceTintColor:Colors.white,
           child: Column(children: [
            UserAccountsDrawerHeader(
              accountName: user.isEmpty ||user==null?Text("loading"): Text("${user[0]["name"]}",style: TextStyle( fontSize:18.0,)), 
              accountEmail: user.isEmpty ||user==null?Text("loading"): Text("${user[0]["email"]}",style: TextStyle( fontSize:18.0,)) ),
             ListTile( title: Text("Home page"),leading:Icon(Icons.home),onTap: () {Navigator.of(context).pushNamed("home");},),ListTile(title: Text("About"),leading:Icon(Icons.search),onTap: () {},),ListTile(title: Text("Help"),leading:Icon(Icons.help),onTap: () { Navigator.of(context).pushNamed("request");},),ListTile(title: Text("log out"),leading:Icon(Icons.logout),onTap: () async {await FirebaseAuth.instance.signOut();Navigator.of(context).pushNamed("login");},),
            ],
           ),
 ),
      appBar: AppBar(elevation: 0, backgroundColor:Color.fromARGB(255, 30, 82, 30),automaticallyImplyLeading: false,
          title: const Center(child:Text("Home",style: TextStyle(color:Colors.white),)),leading: Builder(
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
      body:
       Column(
         children: [
           // ignore: avoid_unnecessary_containers
           Container(
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _weather = snapshot.data;
                    if (this._weather == null) {
                      return Text("Error getting weather");
                    } else {
                      return  weatherBox(_weather);
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              future: getCurrentWeather(),
            ),
      ),
         ],
       )
    );
  }
}

Widget weatherBox(Weather _weather) {
 List status=[
      {
        "name":"Light\n   Distance","measurement":"50","icon":"images/asset/lights.png"
      },{
        "name":"Environment\n   Temperature","measurement":"50","icon":"images/asset/warming.png"
      },{
        "name":"Humidity","measurement":"50","icon":"images/asset/humidity.png"
      },{
        "name":"ph","measurement":"50","icon":"images/asset/ph.png"
      },
      {
        "name":"Water Level","measurement":"30","icon":"images/asset/sea-level.png"
      },
      {
        "name":"Nutrient","measurement":"522","icon":"images/asset/nutrients.png"
      }
    ];
 return Expanded(
child: ListView(
  scrollDirection : Axis.vertical,
  //shrinkWrap: true,
  physics: BouncingScrollPhysics(),
children: [ Column(
    children: [
       Padding(
          padding: EdgeInsets.all(15),
          child: Card(elevation:20,
          child:
          Container(
           width:600,
           height:400,
           margin: EdgeInsets.all(1),
           padding: EdgeInsets.only(top:5),
           decoration: BoxDecoration( 
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient (colors: [  Color.fromARGB(255, 44, 104, 44),Color.fromARGB(255, 133, 189, 134)],
            begin:FractionalOffset (0.5,1)) // LinearGradient
          ),
           child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(child:Container(child: Image.asset("images/asset/weather.png",width: 200,),)),
              Container(
                  margin: const EdgeInsets.all(10.0),
                  child: 
                  Text("${_weather.temp} °C",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize:20,letterSpacing: 1.2,color:Colors.white),
                  )
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Text("${_weather.description}",style: TextStyle(fontWeight: FontWeight.w600,fontSize:20,letterSpacing: 1.2,color: Colors.white),)
                ),
                Row(children:
                  [Container( margin: EdgeInsets.all(15),padding: EdgeInsets.only( left: 45,right: 20)
                  ,child: Icon(Icons.opacity,size: 35,color:Color.fromARGB(255, 30, 82, 30),)),
                 Container( margin: EdgeInsets.all(15),padding: EdgeInsets.only( left: 90,right: 10)
                 ,child: Icon(Icons.thermostat,size: 40,color: Color.fromARGB(255, 30, 82, 30)))],),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5.0),padding: EdgeInsets.only( left:45,right: 20,bottom: 25),
                      child: Text("humidity \n ${_weather.humidity} %",style:TextStyle(fontWeight: FontWeight.w500,fontSize:15,letterSpacing: 1.2,color: Colors.white))
                    ),
                    Container(
                  margin: const EdgeInsets.all(5.0),padding: EdgeInsets.only( left: 70,right: 10,bottom: 22),
                  child: Text("H:${_weather.high}°C \nL:${_weather.low}°C",style:TextStyle(fontWeight: FontWeight.w500,fontSize:15,letterSpacing: 1.2,color:Colors.white))
                ),
                  ],

                ), ]),)),
          
        ),
const SizedBox(height: 10),
     Container( width:600,
          height:605,
          margin: EdgeInsets.only(top:20,),
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),),
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                 decoration: BoxDecoration( 
                  borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient (colors: [ Color.fromARGB(255, 44, 104, 44),Color.fromARGB(255, 180, 221, 181)],
            begin:FractionalOffset (0.5,1)) // LinearGradient
          ),
                width: 600,
                margin: EdgeInsets.only(bottom:2,left: 18,right:18,),
                padding: EdgeInsets.only(bottom:20,top: 22,left: 15,right: 20),
               child: Text("Status",style:const TextStyle(fontWeight: FontWeight.w500,fontSize:22,letterSpacing: 1.2,color: Colors.white,height: 1),),),
              Expanded(child:Container(width:500,padding: EdgeInsets.all(8),margin: EdgeInsets.all(11),
                child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,mainAxisSpacing:10,crossAxisSpacing: 10),
                children:List.generate (status.length, (index){
                  return Padding(
                    
               padding: EdgeInsets.all(0),
               child: Card( elevation: 22,
               //color: Color.fromARGB(255, 101, 97, 97),
               child:
                  Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),color:  Colors.white,),
                    //color: Color.fromARGB(255, 199, 222, 199)
                    height:50,
                    padding: EdgeInsets.all(6),
                    child: Column(
                      children: [
               const SizedBox(height: 20),
                        Row(children: [
                          Image.asset(status[index]["icon"],width:30,),
                          Text("   ${status[index]["name"]}",style: TextStyle(fontWeight: FontWeight.w600,fontSize:15,letterSpacing: 1.2,color: Color.fromARGB(221, 31, 30, 30))),
                          ]),
               const SizedBox(height: 30),
                          Row(children: [
                          Text("   ${status[index]["measurement"]}  ",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20)),
                          ]),
               const SizedBox(height:30),
                      ],
  
                    ),

               )));
                })),
              )
              
              
          )])


     ),
    ],
)])
  ); 








}
Future getCurrentWeather() async {
  Weather weather=Weather(temp: 22, humidity: 55, low: 3, high:55, description: "description");
 String url22="https://api.openweathermap.org/data/2.5/weather?q=irbid&units=metric&appid=bb0fe449f2dbe4068c7e17b8ac1bf560";
 Uri url = Uri.parse(url22);
  final response = await http.get(url);
   // ignore: unused_element
    weather = Weather.fromJson(jsonDecode(response.body));

  return weather;
}