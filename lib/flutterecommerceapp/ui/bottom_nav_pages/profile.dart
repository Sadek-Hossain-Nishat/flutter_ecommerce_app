import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  TextEditingController? _nameController  ;
  TextEditingController? _phoneController ;
  TextEditingController? _ageController ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child:
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: 
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users-form-data').doc(FirebaseAuth.instance.currentUser!
            .email).snapshots(),
            builder: (context,snapshot){

              var data = snapshot.data;
              if(data==null) {
                return Center(
                  child: CircularProgressIndicator(),

                );
              }
              return setDataToTextField(data!);
            },

          ),
        )
      )
    );
  }

  updateData() {
    
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "name":_nameController!.text,
      "phone":_phoneController!.text,
      "age":_ageController!.text
      
    })
    .then((value) => print("updated Successfully"))
    .catchError((error)=>print("Failed=>${error.toString()}"));

  }

  Widget setDataToTextField(DocumentSnapshot<Map<String, dynamic>> data) {

    return  Column(
      children: [
        TextFormField(
          controller: _nameController = TextEditingController(text: data['name']),
          style: TextStyle(color: Colors.black),
        ),
        TextFormField(
          controller: _phoneController=TextEditingController(text: data['phone']),
            style: TextStyle(color: Colors.black)
        ),
        TextFormField(
          controller: _ageController=TextEditingController(text: data['age']),
            style: TextStyle(color: Colors.black)
        ),
        ElevatedButton(onPressed: ()=>updateData(), child: Text('Update'))
      ],
    );


  }
}
