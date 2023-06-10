// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_new, dead_code, unused_local_variable, avoid_single_cascade_in_expression_statements, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:training1/logg/CreatAccount.dart';
import 'package:training1/logg/forgetpassword.dart';
import 'package:training1/logg/hompage.dart';
import 'package:training1/logg/login.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String email;
  late String password;
  GlobalKey<FormState>formkey=new GlobalKey<FormState>();
  var fm=FirebaseMessaging.instance;
 bool validatsave() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

   void validateAndSubmit() async {
    if (validatsave()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        print("no error");
        Navigator.of(context).pushNamed("home");
      }on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    AwesomeDialog(context:context,title:'error',dialogType: DialogType.error,
    btnOkOnPress: () {},body:Text("No user found for that email."))..show();
    
  } else if (e.code == 'wrong-password') {
    AwesomeDialog(context:context, title:'error',
    btnOkOnPress: () {},body:Text("Wrong password provided for that user."))..show();
     }}
 }}
@override
 void initState() {
      fm.getToken().then((tocen){
   print(tocen);
   print("------------------------------------------------------------------");
  });
  var user =FirebaseAuth.instance.currentUser;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 195, 228, 196),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
        child:Form(key: formkey,
          child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const SizedBox(height:23),
       Container(width:550,padding: EdgeInsets.all(0),child: Image.asset("images/asset/11-removebg-preview.png")),
const SizedBox(height:20),
const Text("Let's Watering With Us ",style:TextStyle(fontSize:20,fontWeight: FontWeight.w700,color: Color.fromARGB(255, 30, 82, 30)),),
const SizedBox(height:10),
       
       Center(
         child: TextFormField(
          validator: (value) => value!.isEmpty?'Email can\'t be empty':null,
          onSaved: (val) => email = val!,
           style: TextStyle(color: Color.fromARGB(255, 52, 51, 51)),
           decoration: InputDecoration(border: OutlineInputBorder( borderSide:BorderSide(width : 1.0)),prefixIcon: Icon(Icons.alternate_email,color: Color.fromARGB(255, 47, 45, 45),),hintText: "Email"),
         ),
       ),
const SizedBox(height: 10),
       Center(
         child: TextFormField(validator: (value) => value!.isEmpty?'Password can\'t be empty':null,
          onSaved: (val) => password = val!,
           obscureText: true,
           style: TextStyle(color: Color.fromARGB(255, 52, 51, 51)),
           decoration: InputDecoration(border: OutlineInputBorder( borderSide:BorderSide(width : 1.0)),prefixIcon: Icon(Icons.lock ,color:Color.fromARGB(255, 47, 45, 45),),hintText: "Password"),
         ),
       ),
const SizedBox(height: 35),
        Center(
          child: MaterialButton(
            onPressed:validateAndSubmit, 
            child: Container(
        
              padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 12),
              decoration: BoxDecoration(color: Color.fromARGB(255, 30, 82, 30), borderRadius: BorderRadius.circular(10)),
              child: const Text("login",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600,),),
             ),
               ),
        ),

        Center(child: TextButton(
            onPressed:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ResetPasswordScreen())), child:const Text(' Forget my password',style: TextStyle(color:Color.fromARGB(221, 48, 45, 45),fontSize:12,letterSpacing: 1,fontWeight: FontWeight.w600),))) ,
        const SizedBox(height: 35),
        Center(child: TextButton(onPressed:(){Navigator.of(context).pushNamed("creat");},child:const Text('Creat An Account',style: TextStyle(color: Color.fromARGB(221, 48, 45, 45),fontSize: 18,letterSpacing: 1,fontWeight: FontWeight.w600),))) ,
       ],

      ) )))
      
    );
  }
}
