import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/models/product.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  Product prd = Product();
  var formKey = GlobalKey<FormState>();
  var ProductCollaction = FirebaseFirestore.instance.collection("product");
  SavaData(){
    formKey.currentState!.save();
    ProductCollaction.add({
      "name": prd.name,
      "price": prd.price,
      "imgUrl":prd.imgUrl
    }).then((_){
      Navigator.of(context).pop();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey ,
            child: ListView(
          children: [
            TextFormField(
              onSaved: (val){
                  setState(() {
                    prd.name = val!;
                  });
              },
              decoration: InputDecoration(
                label: Text("Product Name")
              ),
            ),
            TextFormField(
              onSaved: (val){
                prd.price = double.parse(val!);
              },
              decoration: InputDecoration(
                label: Text("Product Price")
              ),
            ),
            TextFormField(
              onSaved: (val){
                prd.imgUrl = val!;
              },
              decoration: InputDecoration(
                label: Text("Product Img Url")
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){
              SavaData();
              }, child: Text("Save")),
            )
          ],
        )),
      ),
    );
  }
}


