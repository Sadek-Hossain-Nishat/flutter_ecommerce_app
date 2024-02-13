import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:SafeArea(child:StreamBuilder(
       stream: FirebaseFirestore.instance.collection("users-cart-items").doc(FirebaseAuth.instance.currentUser!.email)
         .collection("items").snapshots()
     ,
     builder:(context,snapshot){
         if(snapshot.hasError){
           return Center(
             child:Text('${snapshot.error}')
           );
         }

         return ListView.builder(
           itemCount: snapshot.data?.docs.length??0
         ,itemBuilder:(_,index){

             DocumentSnapshot  _documentSnapshot = snapshot.data!.docs[index];

             return Card(
               elevation:5,
               child: ListTile(
                 leading:Text( _documentSnapshot['name'],style: TextStyle(color: Colors.black),),
                 title: Text('\$ ${ _documentSnapshot['price']}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                 trailing:
                 GestureDetector(
                   onTap: (){
                     
                     FirebaseFirestore.instance.collection("users-cart-items")
                         .doc(FirebaseAuth.instance.currentUser!.email)
                         .collection("items")
                         .doc(_documentSnapshot.id).delete();
                     
                   },
                   child: CircleAvatar(
                     child:Icon(Icons.remove_circle)
                   ),
                 )
               ),
             );

         }
         );
     }))
    );
  }
}
