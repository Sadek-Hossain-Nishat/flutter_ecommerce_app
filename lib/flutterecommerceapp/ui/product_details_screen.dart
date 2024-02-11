import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/flutterecommerceapp/widgets/customButton.dart';

import '../const/AppColors.dart';

class ProductDetails extends StatefulWidget {
  
  var _product;
  ProductDetails(this._product);
  

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  
  Future addToCart()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-cart-items");
    return _collectionRef.doc(currentUser!.email).collection("items").doc().set(
      {
        "name":widget._product["product-name"],
        "price":widget._product["product-price"],
        "images":widget._product["product-img"],

      }
    ).then((value) => print("Added to cart"))
    .catchError((error)=>print('ERROR IS  ${error}'));
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.deep_orange,
            child: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon:Icon(Icons.arrow_back,color: Colors.white,)),
          ),
        ),
        actions: [

          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: CircleAvatar(
              backgroundColor: AppColors.deep_orange,
              child: IconButton(onPressed: (){

              }, icon:Icon(Icons.favorite_outline,color: Colors.white,)),
            ),
          )

        ],
      ),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.only(left:12,right:12,top:10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(aspectRatio: 3.5,

              child:
              CarouselSlider(items: widget._product['product-img'].map<Widget>((item) =>Padding(
                padding: EdgeInsets.only(left: 3,right: 3),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image:NetworkImage(item),
                        fit: BoxFit.fitWidth),

                  ),

                ),
              )).toList(), options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (val,carouselPageChangedReason){

                    setState(() {



                    });

                  }
              )),
            ),
            Text(widget._product['product-name'],style:TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold,fontSize: 25)),
            Text(widget._product['product-description'],style:TextStyle(color: Colors.black)),
            SizedBox(height: 10,),
            Text("\$ ${widget._product['product-price'].toString()}",style:TextStyle(color: Colors.red,
            fontWeight: FontWeight.bold,fontSize: 30)),
            Divider(),

            customButton("Add to cart",(){

              addToCart();

            }),
          ],
        ),
      )),
    );
  }
}