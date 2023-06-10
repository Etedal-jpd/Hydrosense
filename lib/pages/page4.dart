// ignore_for_file: unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class SwitchApp extends StatefulWidget {
  const SwitchApp({super.key});

  @override
  State<SwitchApp> createState() => _SwitchAppState();
}

class _SwitchAppState extends State<SwitchApp> {
  @override
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
    retrieved();
}




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
          title: const Center(child:Text("Reset",style: TextStyle(color:Colors.white),)),leading: Builder(
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
    body: MaterialApp(
      debugShowCheckedModeBanner:false,
      theme: ThemeData(useMaterial3: true),
      home: const Scaffold(
        backgroundColor: Color.fromARGB(255, 195, 228, 196),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                    Icon(Icons.lightbulb_outline,size: 80,color: Colors.yellow,),
                SizedBox(height: 20),
                   Center(child: Text('Are you sure you want to reset the hydroponics system?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,),) ,
                    SizedBox(height: 20),
                    Center(
              
              
                      child: SwitchExample(),
                    
                  
                ),
              ],
            ),
        
        ),
    )
  
  );}
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light = true;
  List user=[];
  @override
  void initState() {
    super.initState();
    retrieved();
  }
  retrieved() async{
    String userId = FirebaseAuth.instance.currentUser!.uid;
     DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users").child(userId).child('data');
     final snapshot = await userRef.get();
if (snapshot.exists) {
    user.add(snapshot.value);
     print("Data retrieved successfully");
    user.isEmpty || user[0]["reset"] == null ? light=false : light=true;
} else {
    print('No data available.');
}

  }
  updat()async{
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users").child(userId).child('data');
        await userRef.update({
            "reset-retrieve":user[0]["reset"],
            "reset":user[0]["reset"].toString()
        } );
          Notificationfun();

      print('Data updated successfully');

               } catch (e) {
         print('Error updating data: $e');
               }
            }


  String title="";
  String notification1="";
  String notification2="";

  Notificationfun() async {
    if (user.isNotEmpty && user[0]["Nutrient-tank"] != null && user[0]["Nutrient-tank"] <= 30) {
      title = "Wrong";
      notification1 = "Amount of water in the Nutrient Tank is less than 20%. Please fill the tank";
      notification2 = "Amount of water in the Main Tank is less than 20%. Please fill the tank";
      getMessagetoupdate(title, notification1, notification2);
    }

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
      print('Data updated successfully');
    } catch (e) {
      print('Error updating data: $e');
    }

  }

  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Color?> trackColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        // Track color when the switch is selected.
        if (states.contains(MaterialState.selected)) {
          return Colors.green;
        }
        // Otherwise return null to set default track color
        // for remaining states such as when the switch is
        // hovered, focused, or disabled.
        return null;
      },
    );
    final MaterialStateProperty<Color?> overlayColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        // Material color when switch is selected.
        if (states.contains(MaterialState.selected)) {
          return Colors.green.withOpacity(0.54);
        }
        // Material color when switch is disabled.
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey.shade400;
        }
        // Otherwise return null to set default material color
        // for remaining states such as when the switch is
        // hovered, or focused.
        return null;
      },
    );

    return Switch(
      // This bool value toggles the switch.
      value:  user.isEmpty || user[0]["reset"] == null ? light : user[0]["reset"],
      overlayColor: overlayColor,
      trackColor: trackColor,
      thumbColor: const MaterialStatePropertyAll<Color>(Colors.white),
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
           user[0]["reset"] = value;
           updat();
           retrieved();
           Notificationfun();
        });
      },
    );
  }
}