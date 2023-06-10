
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Aboutus extends StatelessWidget {

  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 195, 228, 196),

      appBar: AppBar(title: Center(child: Text('About Us',style: TextStyle(color: Colors.white),)),backgroundColor:Color.fromARGB(255, 30, 82, 30),),
      body: Padding(
          padding: const EdgeInsets.all(20.0),

          child:
          SingleChildScrollView(
            child: Column(


                children: [


                  Center(
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [



                            SizedBox(height:35,),
                            Center(child: Text("Welcome to Hydrosense",style:TextStyle(fontSize: 22,fontWeight:FontWeight.w500) ,),),


                          ],


                        ),
                      )

                  ),

                  SizedBox(height:20,),
                  Row(
                    children: [
                      Container(child: Image.asset("images/asset/aboutus1.png",alignment: Alignment.centerRight,width: 130, height: 180,fit: BoxFit.fill,)),
                      SizedBox(width: 10,),
                      Container(child: Expanded(child: Text('\nThe cutting-edge application that transforms the way we cultivate lettuce through hydroponic systems. We are passionate about leveraging technology to revolutionize farming practices and empower individuals to grow their own fresh, healthy produce.',maxLines:20,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),)
                    ],
                  )
                  ,
                  SizedBox(height:2,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(child: Expanded(child: Text('With Hydrosense, you can effortlessly establish and maintain a thriving hydroponic lettuce garden right in the comfort of your home or any other suitable indoor environment',maxLines:20,textAlign: TextAlign.start,style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500),)),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(child: Image.asset("images/asset/aboutus2.png",alignment: Alignment.centerRight,width: 140, height: 180,fit: BoxFit.fill,)),
                      SizedBox(width: 10,),
                      Container(child: Expanded(child: Text('At Hydrosense, we understand the growing need for sustainable and efficient agricultural practices, given the challenges of limited land availability and adverse environmental impacts associated with traditional farming methods.',maxLines:20,style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500),)),),


                    ],
                  )
                  ,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height:10,),
                      Container(child: Expanded(child: Text('\nOur goal is to provide an accessible and user-friendly solution that harnesses the power of hydroponics, enabling anyone, regardless of their gardening experience, to cultivate delicious, pesticide-free lettuce year-round.',maxLines:20,textAlign: TextAlign.start,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500
                      ),)),),
                    ],
                  ),
                  SizedBox(height: 30,),

                  Row(
                    children: [
                      // Container(child: Image.asset("images/asset/r.png",alignment: Alignment.centerRight,width: 130, height: 180,fit: BoxFit.cover,)),
                      SizedBox(width: 5),
                      Container(child: Expanded(child: Text('Our application seamlessly integrates with your hydroponic system, providing you with real-time monitoring, control, and optimization capabilities. Through the use of advanced sensors and IoT connectivity, Hydrosense constantly tracks crucial parameters such as water pH levels, nutrient concentration, temperature, and humidity.',maxLines:20,style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500),)),)
                    ],
                  )
                  ,
                  SizedBox(height:2,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(child: Expanded(child: Text('This data is then analyzed using our intelligent algorithms to ensure optimal growing conditions for your lettuce plants.',maxLines:20,textAlign: TextAlign.start,style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500),)),),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Container(child: Expanded(child: Text('With Hydrosense, you no longer need to worry about manually adjusting nutrient levels or constantly monitoring your hydroponic system.',maxLines:20,style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500),)),),
                      SizedBox(width:5),
                      //Container(child: Image.asset("images/asset/r.png",alignment: Alignment.centerRight,width: 140, height: 180,fit: BoxFit.cover,)),


                    ],
                  )
                  ,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(child: Expanded(child: Text('Our application automates these processes, allowing you to sit back and relax while it takes care of the intricate details. You can conveniently manage your garden from anywhere, anytime, using our intuitive mobile interface.',maxLines:20,textAlign: TextAlign.start,style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500),)),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      // Container(child: Image.asset("images/asset/r.png",alignment: Alignment.centerRight,width: 130, height: 180,fit: BoxFit.cover,)),
                      SizedBox(width: 5,),
                      Container(child: Expanded(child: Text('At Hydrosense, sustainability is at the core of everything we do. By adopting hydroponic techniques, our application promotes water conservation by using up to 90% less water compared to conventional soil-based agriculture',maxLines:20,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),)
                    ],
                  )
                  ,
                  SizedBox(height:2,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(child: Expanded(child: Text('Additionally, our pesticide-free approach eliminates the need for harmful chemicals, resulting in a safer, healthier lettuce for you and your loved ones.',maxLines:20,textAlign: TextAlign.start,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(child: Expanded(child: Text('Join the Hydrosense community today and embark on a journey of effortless, rewarding lettuce cultivation. Experience the joy of picking fresh, crisp lettuce leaves straight from your own indoor garden, knowing that you are contributing to a greener, more sustainable future.',maxLines:20,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),),
                      SizedBox(width: 10),
                    ],
                  )
                  ,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(child: Expanded(child: Text('With Hydrosense, the future of hydroponic gardening is in your hands.',maxLines:20,textAlign: TextAlign.start,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,fontFamily: ''),)),),
                    ],
                  ),
                  SizedBox(height: 1,),
                  Container(child: Image.asset("images/asset/11-removebg.png",alignment: Alignment.centerRight,width:190, height: 180,fit: BoxFit.fill,)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(child: Expanded(child: Text('Start your hydroponic lettuce revolution with Hydrosense today!',maxLines:20,textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),),
                    ],
                  ),


                ]),
          )),
    );
  }
}