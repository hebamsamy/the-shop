import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/EditProduct.dart';
import 'package:shop/addProduct.dart';
import 'package:shop/models/product.dart';

class HomeScreen extends StatelessWidget {
  var ProductCollaction = FirebaseFirestore.instance.collection("product");

  deleteProduct(String id, BuildContext ctx) {
    ProductCollaction.doc(id).delete().then((_) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text("Deleted succfully")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed("/register");
          }, icon: Icon(Icons.person))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("product").snapshots(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.active ||
                snapshots.connectionState == ConnectionState.done) {
              if (snapshots.data!.docs.length != 0) {
                return ListView(
                  children: snapshots.data!.docs.map((item) {
                    return Dismissible(
                      onDismissed: (direction) {
                        deleteProduct(item.id, context);
                      },
                      key: ValueKey(item.id),
                      child: Card(
                        child: ListTile(
                          title: Text(item.data()["name"]),
                          leading: CircleAvatar(
                            child: Image.network(item.data()["imgUrl"]),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        EditProductScreen(id: item.id)));
                              },
                              icon: Icon(Icons.edit)),
                        ),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return Center(
                  child: Text("NO Data Yet"),
                );
              }
            } else {
              //show loader
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddProductScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
