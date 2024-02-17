import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/flutterecommerceapp/business-logic/counter.dart';
import 'package:provider/provider.dart';

class FlutterProvider extends StatelessWidget {
  const FlutterProvider({super.key});



  @override
  Widget build(BuildContext context) {

    final _counter = Provider.of<Counter>(context,listen: true);
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          Text(_counter.value.toString(),style: TextStyle(fontSize: 50,color:Colors.black),),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              ElevatedButton(onPressed: ()=>_counter.increment(), child: Text("Increment")),
              ElevatedButton(onPressed: ()=>_counter.decrement(), child: Text("Decremengt"))

            ],
          )
        ],
      )),
    );
  }
}
