import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  double tree=50;
late AnimationController moveController;
late Animation moveAnimation;
  @override
  void initState() {
    Timer.periodic(const Duration(milliseconds: 20), (timer) { 
      setState(() {
        tree +=5;
      });
      
      if(tree >= 750){
        setState(() {
          tree=-50;
        });
        
      }
    });
   moveController=AnimationController(vsync: this, duration: Duration(milliseconds:200 )
   );
   
   moveAnimation=Tween<double>( begin: -2,end: 0).animate(moveController);
   moveController.addListener(() { 
     if(moveAnimation.status==AnimationStatus.completed){
       moveController.reverse();
     }
     setState(() {
       
     });
     
   });
   
   moveController.repeat(reverse: true);
   
    super.initState();
  }
  bool light=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          setState(() {
            light=!light;
          });
        },
       
        child: Center(
          child: Stack(
            children: [
              Image.asset("assets/Img_1.png"),
              Positioned(
               bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  // alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: 50,
                  color: const Color(0xff261d37),
                ),
              ),
           Positioned(
             bottom: 50,
               right:tree,
               child: Image.asset('assets/Img_03.png')),
              Positioned(
                  bottom: 50.0+moveAnimation.value,
                  left: MediaQuery.of(context).size.width/5,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset('assets/Img_05.png'),
                     light? Positioned(
                        left: 150,
                          bottom: 0,
                          child:
                          CustomPaint(
                            
                            size: Size(140, 20),
                            painter: DrawLight(),
                          )
                      
                      
                      ):SizedBox.shrink()
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawLight extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
   final path= Path();
   final paint=Paint()..shader=LinearGradient(colors: [
     // Colors.yellow.withOpacity(0.5),
     Colors.yellow.withOpacity(0.4),
     Colors.yellow.withOpacity(0.3),
     Colors.yellow.withOpacity(0.2),
     Colors.yellow.withOpacity(0.1),
   ]).createShader(Rect.fromCircle(center: Offset(50, 15), radius: 10));
   path.moveTo(0, 0);
   path.lineTo(size.width, size.height);
   path.relativeLineTo(-size.width+30,0);
   path.close();
   
   canvas.drawPath(path, paint);
   
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;
  
}
