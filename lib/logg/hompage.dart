import 'package:flutter/material.dart';

import 'package:training1/pages/page33/calendar_tile.dart';
import 'package:training1/pages/page1.dart';
import 'package:training1/pages/page2/page22.dart';
import 'package:training1/pages/page4.dart';




class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  PageController pagecontroller=PageController();
  List<Widget> child=[
  CurrentWeatherPage(),
  requests(),
  page2(),
  SwitchApp(),


];
  int select=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 195, 228, 196),
     bottomNavigationBar: BottomNavigationBar( 
          selectedItemColor:Color.fromARGB(255, 30, 82, 30),
          unselectedItemColor:Colors.grey,
          currentIndex: select,
          onTap: (index) {setState(() {
            select =index;
          }); 
          },
          items:const [ BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.notification_add),label: 'Notification'),
            BottomNavigationBarItem(icon: Icon(Icons.new_label),label: 'Timer'),
            BottomNavigationBarItem(icon: Icon(Icons.restart_alt),label: 'Reset'),]

       ), 
       body:Center(child: child[select])
       );
  }}