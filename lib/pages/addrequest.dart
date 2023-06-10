// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';

class addReq extends StatefulWidget {
  const addReq({super.key});

  @override
  State<addReq> createState() => _addReqState();
}

class _addReqState extends State<addReq> {
  DateTime selectdate =DateTime.now();
  var selectproblem;
  var title,note,date;
   GlobalKey<FormState>formkey=new GlobalKey<FormState>();
addData ()async{

String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users").child(userId);
await userRef.child('request').set({
  'problem': selectproblem,
  'note': note,
  'date': date,
});}


    bool validatsave() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      setState(() {
              addData ();
      });
      showDialog(context: context,builder: (context) {
      return AlertDialog(titlePadding: EdgeInsets.only(top:20,left: 10),contentPadding: EdgeInsets.all(20),
      title: Text('sent successfully',style: TextStyle(color: Color.fromARGB(255, 5, 42, 6)),),
      actions: [FloatingActionButton(onPressed: (){Navigator.of(context).pop("request");},child: Text('Ok'),)],
      );
        });
      return true;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(255, 195, 228, 196),
      appBar: 
    AppBar(elevation: 0, backgroundColor:Color.fromARGB(255, 30, 82, 30),
      leading: Builder(builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.arrow_back,color:Colors.white,),
        onPressed: () { Navigator.of(context).pop("page3"); });})),
    // ignore: prefer_const_constructors



    body:Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView(scrollDirection : Axis.vertical,
        physics: BouncingScrollPhysics(),
          children:[Container(padding: EdgeInsets.all(20),child:Form(key: formkey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            Container(padding: EdgeInsets.only(bottom: 40),child: Text('Add New Request',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600), )),
const SizedBox(height: 10),
           Text("Title",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),const SizedBox(height: 10),
            Container(padding: EdgeInsets.only(bottom: 10),child: DropdownButton(hint: Text("problem type"),iconEnabledColor: Colors.green,iconSize: 20,itemHeight: 50,isExpanded: true ,
            items: ["sensors","pumps","Hydroponic system","other"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (value) { setState(() {
              selectproblem=value;
            }); },
            value: selectproblem,
            )),
           if (selectproblem=="other") Container(padding: EdgeInsets.only(bottom: 40),
             child: TextFormField( onSaved: (val) => selectproblem = val!,
             style: TextStyle(color: Color.fromARGB(255, 52, 51, 51)),
             decoration: InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1)))),
           ),
const SizedBox(height: 10),
             Text("Note",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),const SizedBox(height: 10),
            Container(padding: EdgeInsets.only(bottom: 20),child: TextFormField( onSaved: (val) => note = val!,
           style: TextStyle(color: Color.fromARGB(255, 52, 51, 51)),
           decoration: InputDecoration(border: OutlineInputBorder( borderRadius: BorderRadius.circular(12),borderSide:BorderSide(width : 5)),hintText: "....."),
         ),),
const SizedBox(height: 10),
            Text("Date",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),const SizedBox(height: 10),
            Container(padding: EdgeInsets.only(bottom: 90),child: TextFormField( onSaved: (val) => date = val!,validator: (value) => value!.isEmpty?'Date can\'t be empty':null,
           style: TextStyle(color: Color.fromARGB(255, 52, 51, 51)),
           decoration: InputDecoration(border: OutlineInputBorder( borderRadius: BorderRadius.circular(12),borderSide:BorderSide(width : 1.0)),hintText:DateFormat.yMd().format(selectdate)),
         ),),
 Center(
          child: MaterialButton(
            onPressed:validatsave, 
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 12),
              decoration: BoxDecoration(color:Color.fromARGB(255, 30, 82, 30), borderRadius: BorderRadius.circular(10)),
              child: const Text("send",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600,),),
             ),
               ),
        ),


          ]),))





          
       ] )));
  }
}

