// ignore_for_file: prefer_const_constructors, unused_import, file_names, use_build_context_synchronously, avoid_print, unused_local_variable, void_checks, deprecated_member_use
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:training1/logg/CreatAccount.dart';
import 'package:training1/logg/hompage.dart';
import 'package:training1/logg/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatA extends StatefulWidget {
  const CreatA({super.key});

  @override
  State<CreatA> createState() => _CreatAState();
}

class _CreatAState extends State<CreatA> {
  String country2="jordan";
  bool v=false;
  late String name="etedal33";
  late String phone="0000";
late String newPassword="etedal33";
 late String newEmail="etedal0799@gmail.com";
  GlobalKey<FormState>formkey=new GlobalKey<FormState>();
final DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users');
  bool validatsave() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
addData ()async{
 if (newEmail != 'etedal0799@gmail.com') {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: newEmail, password: newPassword);
      String userId = userCredential.user!.uid;

      await userRef.child(userId).set({
        'name': name,
        'email': newEmail,
        'phone': phone,
        'start': "",
        'finishd': "",
        "country": country2,
      });

      print('Data added successfully');
    } catch (e) {
      print('Error adding data: $e');
    }
  }
}

  void validateAndSubmit() async {
    if (validatsave()) {
      try {
        addData();
        AwesomeDialog(context:context,title:'welcome to WaterSavvy',dialogType: DialogType.success,
         btnOkOnPress: () {},body:Text("We will contact you within 24 hours and activate the account. Thank you.")).show();
      } on FirebaseAuthException catch (e) {
   if (e.code == 'weak-password') {
    // ignore: avoid_single_cascade_in_expression_statements
    AwesomeDialog(context:context,title:'error',dialogType: DialogType.error,
    btnOkOnPress: () {},body:Text("The password provided is too weak."))..show();
   } else if (e.code == 'email-already-in-use') {
    // ignore: avoid_single_cascade_in_expression_statements
    AwesomeDialog(context:context,title:'error',dialogType: DialogType.error,
    btnOkOnPress: () {},body:Text("The account already exists for that email."))..show();
   }} 
   catch (e) {
  print(e);
}}}
@override
  void initState() {
    // TODO: implement initState
    addData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 195, 228, 196),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
        child: Form(key: formkey,
         child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
const SizedBox(height:60),

       Row(
         children: [

           Container(padding: EdgeInsets.all(0),
            child: Container(padding: EdgeInsets.all(0),child: Image.asset("images/asset/11preview.png"),width:100,),),
             Center(child: const Text(" Request \n to Creat New Account",style:TextStyle(fontSize:20,fontWeight: FontWeight.w700,color: Color.fromARGB(221, 48, 45, 45)),)),
         ],
       ),
      
const SizedBox(height: 30),
       Center(
           child: TextFormField(
            validator: (value) => value!.isEmpty?'Username can\'t be empty':null,
            onSaved: (val) => name = val!,
           style: TextStyle(color: Color.fromARGB(255, 52, 51, 51)),
           decoration: InputDecoration(border: OutlineInputBorder( borderSide:BorderSide(width : 1.0)),
           prefixIcon: Icon(Icons.alternate_email,color: Color.fromARGB(255, 47, 45, 45),),
           hintText: "Username"),
         ),
       ),
const SizedBox(height: 10),
       Center(
           child: TextFormField(
            validator: (value) => value!.isEmpty?'Password can\'t be empty':null,
            onSaved: (val) => newEmail = val!,
           style: TextStyle(color: Color.fromARGB(255, 52, 51, 51)),
           decoration: InputDecoration(border: OutlineInputBorder( borderSide:BorderSide(width : 1.0)),prefixIcon: Icon(Icons.email,color: Color.fromARGB(255, 47, 45, 45),),hintText: "Email"),
         ),
       ),
const SizedBox(height: 10),
       Center(
         child: TextFormField(
           validator: (value) => value!.isEmpty?'Password can\'t be empty':null,
            onSaved: (val) => newPassword = val!,
           obscureText: true,
           style: TextStyle(color: Color.fromARGB(255, 52, 51, 51)),
           decoration: InputDecoration(border: OutlineInputBorder( borderSide:BorderSide(width : 1.0)),prefixIcon: Icon(Icons.lock ,color:Color.fromARGB(255, 47, 45, 45),),hintText: "Password"),
         ),
       ),
const SizedBox(height: 10),
       Center(
         child: CSCPicker(
          layout: Layout.vertical,
          //flagState: CountryFlag.DISABLE,
          onCountryChanged: (country) { validator: (value) => value!.isEmpty?'country can\'t be empty':null; onSaved: (val) => country2 = val;},
          onStateChanged: (state) {},
          onCityChanged: (city) {},
          countryDropdownLabel : "Country",
          showStates: true,
          
          /* countryDropdownLabel: "*Country",
          stateDropdownLabel: "*State",
          cityDropdownLabel: "*City",*/
          //dropdownDialogRadius: 30,
          //searchBarRadius: 30,
       )),
const SizedBox(height: 10),
       Center(
         child: TextFormField(
           validator: (value) => value!.length<10 || value!.length>10?'phone number invalid' :null,
           onSaved: (val) => phone = val!,
           style: TextStyle(color: Color.fromARGB(255, 52, 51, 51)),
           decoration: InputDecoration(border: OutlineInputBorder( borderSide:BorderSide(width : 1.0)),prefixIcon: Icon(Icons.call,color:Color.fromARGB(255, 47, 45, 45),),hintText: "phone umber"),
         ),
       ),
const SizedBox(height: 30),
        Center(child: MaterialButton(
            onPressed:validateAndSubmit,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 12),
              decoration: BoxDecoration(color: Color.fromARGB(255, 30, 82, 30), borderRadius: BorderRadius.circular(10)),
              child: const Text("send",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600,),),
             ),
               ),
        ),
const SizedBox(height:0),
        Center(child: TextButton(onPressed:(){Navigator.of(context).pushNamed("login");},child:const Text('<- Login',style: TextStyle(color: Color.fromARGB(221, 48, 45, 45),fontSize:16,letterSpacing: 1,fontWeight: FontWeight.w600),))) ,
        //TextButton(onPressed:(){}, child:const Text(' Forgot password',style: TextStyle(color:  Color.fromARGB(221, 48, 45, 45),fontSize: 10,letterSpacing: 1,fontWeight: FontWeight.w600),)) ,
      ],

      ) )))
      
    );
  }
}