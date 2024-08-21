import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/models/product.dart';

class EditProductScreen extends StatefulWidget {
  String id;
  EditProductScreen({required this.id});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  Product prd = Product();
  var formKey = GlobalKey<FormState>();
  var ProductCollaction = FirebaseFirestore.instance.collection("product");
  void initState() {
    super.initState();
    print(widget.id);
    //get one by id
    //display it in 
  }

  SavaData() {
    formKey.currentState!.save();
    //update 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  onSaved: (val) {
                    setState(() {
                      prd.name = val!;
                    });
                  },
                  decoration:
                      const InputDecoration(label: Text("Product Name")),
                ),
                TextFormField(
                  onSaved: (val) {
                    prd.price = double.parse(val!);
                  },
                  decoration:
                      const InputDecoration(label: Text("Product Price")),
                ),
                TextFormField(
                  onSaved: (val) {
                    prd.imgUrl = val!;
                  },
                  decoration:
                      const InputDecoration(label: Text("Product Img Url")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        SavaData();
                      },
                      child: const Text("Save")),
                )
              ],
            )),
      ),
    );
  }
}
