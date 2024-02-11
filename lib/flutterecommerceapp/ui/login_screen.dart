import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_ecommerce_app/flutterecommerceapp/ui/registration_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import '../const/AppColors.dart';
import '../widgets/customButton.dart';
import 'bottom_nav_controller.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: SafeArea(child: Column(
        children: [
          SizedBox(height: 150.h,
            width:ScreenUtil().screenWidth ,
            child: Padding(padding: EdgeInsets.only(left: 20.w),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.light,color: Colors.transparent,)),
                  Text('Sign In',style: TextStyle(fontSize: 22.sp,color: Colors.white),)
                ],

              ),),),
          
          Expanded(child: Container(
              width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(28.r),
                      topLeft: Radius.circular(28.r)
                  )
              ) 
          , child: Padding(padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  height: 20.h,
                ),
                Text('Welcome Back',
                style: TextStyle(
                  fontSize: 22.sp,
                  color: AppColors.deep_orange
                ),),
                Text('Glad to see you back my buddy.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xFFBBBBBB)
                ),),
                SizedBox(height: 15.h,),
                Row(
                  children: [
                    Container(
                      height: 48.h,
                      width:41.w,
                      decoration:BoxDecoration(
                        color:AppColors.deep_orange,
                        borderRadius: BorderRadius.circular(12.r),

                      ),
                      child: Center(
                        child: Icon(Icons.email_outlined,
                        color: Colors.white,
                        size: 20.w,),
                      ),
                    ),
                    SizedBox(
                      width: 10.w ,
                    ),
                    Expanded(child: TextField(
                      style:TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xFF414041)
                      ),
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText:'thed9954@gmail.com',
                        hintStyle:TextStyle(
                          fontSize:14.sp,
                          color:Color(0xFF414041)
                        ),


                          labelText:'Email',
                          labelStyle:TextStyle(
                              fontSize:15.sp,
                              color:AppColors.deep_orange
                          )


                      ),

                    ))
                  ],
                ),
                SizedBox(
                  height:10.h
                ),
                Row(
                  children: [
                    Container(
                      height: 48.h,
                      width: 41.h,
                      decoration:BoxDecoration(
                        color: AppColors.deep_orange,
                        borderRadius: BorderRadius.circular(12.r)
                      )
                        ,
                      child: Center(
                        child: Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                          size: 20.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      width:10.w
                    ),
                    Expanded(child: TextField(
                      style: TextStyle(
                        color: Color(0xFF414041)
                      ),
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: 'Password must be 6 characters',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xFF414041)
                        ),
                        labelText:'Password',
                        labelStyle: TextStyle(
                          fontSize:15.sp,
                          color:AppColors.deep_orange
                        ),
                        suffixIcon: _obscureText == true?
                             IconButton(onPressed: (){
                               setState(() {
                                 _obscureText = false;
                               });
                             }, icon: Icon(Icons.visibility_off,size: 20.w,),
                             ):IconButton(onPressed: (){
                               setState(() {
                                 _obscureText = true;
                               });
                        }, icon:Icon(Icons.remove_red_eye,size: 20.w,))

                      ),
                    ))
                  ],
                ),

                SizedBox(
                  height: 50.h,
                ),
                customButton("Sign In",(){
                  signIn();
                }),
                SizedBox(
                  height: 20.h,
                ),
                Wrap(
                  children: [
                    Text("Don't have an account?",style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight:FontWeight.w600,
                      color:Color(0xFFBBBBBB)
                    ),),

                    GestureDetector(
                      child:Text("Sign Up",style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight:FontWeight.w600,
                          color:AppColors.deep_orange
                      ),) ,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
                      },
                    )
                  ],
                )



              ],
            ),
          ),),)
          )
        ],
      )));
  }

  void signIn() async {

    try{
      final credential  =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);

      var authCredential = credential.user;
      print(authCredential!.uid);

      if(authCredential.uid.isNotEmpty) {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>BottomNavController()));
      }
      else{
        // Fluttertoast.showToast(msg: "Something is wrong");
      }


    } on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        // Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {

        print('Wrong password provided for that user.');
        // Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      }

    }
  }
}
