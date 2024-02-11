import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/flutterecommerceapp/const/AppColors.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import 'login_screen.dart';
import 'user_form.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

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
              Text('Sign Up',style: TextStyle(fontSize: 22.sp,color: Colors.white),)
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
            ),
            child: Padding(padding: EdgeInsets.all(20.w),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),
                  Text("Welcome Buddy!",style: TextStyle(
                    fontSize: 22.sp,
                    color: AppColors.deep_orange
                  ),),
                  Text("Glad to see you back my buddy",style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFFBBBBBB)
                  ),),

                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 48.h,
                        width: 41.w,
                        decoration: BoxDecoration(
                          color:AppColors.deep_orange,
                          borderRadius:BorderRadius.circular(12.r),

                        ),
                        child:Center(
                          child:Icon(
                            Icons.email_outlined,
                            color:Colors.white,
                            size:20.w
                          )
                        )
                      ),
                      SizedBox(
                        width:10.w
                      ),
                      Expanded(child: TextField(
                        style: TextStyle(
                          color:Color(0xFF414041)
                        ),
                        controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'thed9954@gmail.com',
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xFF414041),

                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontSize: 15.sp,
                              color: AppColors.deep_orange
                            ),


                          ),
                      ))
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      Container(
                          height: 48.h,
                          width: 41.w,
                          decoration: BoxDecoration(
                            color:AppColors.deep_orange,
                            borderRadius:BorderRadius.circular(12.r),

                          ),
                          child:Center(
                              child:Icon(
                                  Icons.lock_outline,
                                  color:Colors.white,
                                  size:20.w
                              )
                          )
                      ),
                      SizedBox(
                          width:10.w
                      ),
                      Expanded(child: TextField(
                        style: TextStyle(
                            color:Color(0xFF414041)
                        ),
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            hintText: 'password must be 6 character',
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xFF414041),

                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                fontSize: 15.sp,
                                color: AppColors.deep_orange
                            ),
                          suffixIcon: _obscureText==true?IconButton(onPressed: (){
                            setState(() {
                              _obscureText = false;
                            });
                          }, icon: Icon(Icons.visibility_off,size: 20.w,)):
                              IconButton(onPressed: (){
                                setState(() {
                                  _obscureText = true;
                                });
                              }, icon: Icon(Icons.remove_red_eye,size: 20.w,))

                        ),
                      ))
                    ],
                  ),

                  SizedBox(
                    height: 50.h,
                  ),

                  // elevated button

                  SizedBox(
                    height: 56.h,
                    width: 1.sw,
                    child: ElevatedButton(onPressed: (){
                      signUp();
                    }, child: Text('Continue',style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp
                    ),),
                    style: ElevatedButton.styleFrom(

                     backgroundColor: AppColors.deep_orange,
                      elevation: 3

                    )
                      ,),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Wrap(
                    children: [

                      Text("Don't have an account",style: TextStyle(fontSize: 13.sp,fontWeight:FontWeight.w600,color: Color(0xFFBBBBBB)),),

                      GestureDetector(
                        child:Text(" Sign In",style: TextStyle(fontSize: 13.sp,fontWeight:FontWeight.w600,color:AppColors.deep_orange),) ,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        },
                      )

                    ],
                  )

                ],
              ),
              
            ),),
          ))


        ],
      )),
    );
  }

  void signUp() async {


    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      var user = credential.user;
      print(user!.uid);
      if (user.uid.isNotEmpty) {
        print('Successfully Userform');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>UserForm()));

      }else{
        // Fluttertoast.showToast(msg: 'Something is wrong');
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // Fluttertoast.showToast(msg: 'The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // Fluttertoast.showToast(msg: 'The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }



  }
}
