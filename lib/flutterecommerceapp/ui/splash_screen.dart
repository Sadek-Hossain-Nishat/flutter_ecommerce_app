import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/flutterecommerceapp/const/AppColors.dart';
import 'package:flutter_ecommerce_app/flutterecommerceapp/ui/registration_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

   @override
  void initState() {
    // TODO: implement initState
     Timer(Duration(seconds: 3), () {
       Navigator.pushReplacement(context,
       MaterialPageRoute(builder: (_)=>RegistrationScreen()));
     });
    super.initState();



  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: 
      SafeArea(
        child: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('E-Commerce',
              style:TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 44.sp
              )),
              SizedBox(height: 20.h,),

              CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 7,
              )
            ],
          ),
        ),
      ),

    );
  }
}
