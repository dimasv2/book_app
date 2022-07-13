import 'dart:async';

import 'package:book/views/book_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import './views/book_list_page.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
  void initState() {
    // TODO: implement initState
    
    Timer(Duration(seconds: 15), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookListPage() ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text('WELCOME', style: TextStyle(fontSize: 35, 
            color: Color.fromARGB(255, 39, 4, 235), fontWeight: FontWeight.bold),),
            Image.asset('assets/awan.png'),
           //Center(child: FlutterLogo(size: 200)),
            Text('BOOK APP', style: TextStyle(fontSize: 30,
             color: Color.fromARGB(255, 65, 27, 233), fontWeight: FontWeight.bold),),
            Text('REBAHAN', style: TextStyle(fontSize: 20, 
            color: Colors.white, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
    
  }
}