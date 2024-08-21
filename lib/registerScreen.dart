import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  var key = GlobalKey<FormState>();
  String Email = "";
  String Password = "";
  Register() async {
    key.currentState?.save();
    var recponse =  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: Email, password: Password);
    print(recponse);
    // .then((data){
    //   print(data);
    // })
    // .catchError((onError){
    //   print(onError);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: key,
            child: ListView(
              children: [
                TextFormField(
                  onSaved: (newValue) {
                    setState(() {
                      Email = newValue!;
                    });
                  },
                ),
                TextFormField(
                  onSaved: (newValue) {
                    setState(() {
                      Password = newValue!;
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      Register();
                    },
                    child: Text("Register"))
              ],
            )));
  }
}
