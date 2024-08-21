import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
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
  File? image = null;
  String imgErr = "";
  var formKey = GlobalKey<FormState>();
  var storage = FirebaseStorage.instance;
  var ProductCollaction = FirebaseFirestore.instance.collection("product");
  var picker = ImagePicker();
  fromCamera() async {
    var output = await picker.pickImage(source: ImageSource.camera);
    if (output == null) {
      //shoow msg
      setState(() {
        imgErr = "The Product Must have Image";
      });
    } else {
      setState(() {
        image = File(output.path);
        imgErr = "";
      });
    }
  }

  fromGallary() async {
    var output = await picker.pickImage(source: ImageSource.gallery);
    if (output == null) {
      //shoow msg
      setState(() {
        imgErr = "The Product Must have Image";
      });
    } else {
      setState(() {
        image = File(output.path);
        imgErr = "";
      });
    }
  }

  SavaData() {
    formKey.currentState!.save();

    String fileName = DateTime.now().toString();
    
      
    storage.ref(fileName).putFile(image!).then((url) async {
      String imgUrl = await url.ref.getDownloadURL();
       
      ProductCollaction.add(
          {"name": prd.name, "price": prd.price, "imgUrl": imgUrl}).then((_) {
        Navigator.of(context).pop();
      });
    }).catchError((err) => print(err));
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
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  onSaved: (val) {
                    setState(() {
                      prd.name = val!;
                    });
                  },
                  decoration: InputDecoration(label: Text("Product Name")),
                ),
                TextFormField(
                  onSaved: (val) {
                    prd.price = double.parse(val!);
                  },
                  decoration: InputDecoration(label: Text("Product Price")),
                ),
                TextFormField(
                  onSaved: (val) {
                    prd.quantiry = int.parse(val!);
                  },
                  decoration: InputDecoration(label: Text("Product Quantity")),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        child: image == null ? Icon(Icons.add) : null,
                        backgroundImage:
                            image != null ? FileImage(image!) : null,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {
                                fromCamera();
                              },
                              label: Text("Camera"),
                              icon: Icon(Icons.camera),
                            ),
                            OutlinedButton.icon(
                              onPressed: () {
                                fromGallary();
                              },
                              label: Text("Gallary"),
                              icon: Icon(Icons.photo),
                            ),
                            Text(
                              imgErr,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        SavaData();
                      },
                      child: Text("Save")),
                )
              ],
            )),
      ),
    );
  }
}
