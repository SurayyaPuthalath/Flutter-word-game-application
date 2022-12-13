import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fool_game_project/main.dart';
import 'package:fool_game_project/screens/home/working.dart';

class BackendService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


//login
  Future signIn(String email, String password,BuildContext context) async {
  
    showDialog(
    context: context,
  barrierDismissible: false,
   builder: (context) => Center(child: CircularProgressIndicator()));
    try {
    await _auth.signInWithEmailAndPassword(
          email: email, password: password);
       
            navigatorKey.currentState!.popUntil((route) => route.isFirst);
          
             final doc=await FirebaseFirestore.instance.doc('admin/${_auth.currentUser!.uid}').get();
            print(doc.exists);
            if(doc.exists)
            {
              print('1');
                   Navigator.of(context).pushReplacementNamed('adminhome');
            }
            else{
                Navigator.of(context).pushReplacementNamed('home');
            }
            print('2');
          
              
    }on FirebaseAuthException catch (e) {
       navigatorKey.currentState!.popUntil((route) => route.isFirst);
      print(e.toString());
       Working.showSnackBar(e.message,Colors.red);
      
    }
    
   
  }
//signup

  Future signUp(
      String name, String email, String password, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
            try{
      
          await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user)
           {
            
             
                 // print(user.user!.uid);
                 String uidnew=user.user!.uid;
                 print(uidnew);
                
                 FirebaseFirestore.instance.collection('user').doc(uidnew).set({
                  'name':name,
                  'score':0,
                  'wins':0,
                  'failure':0

                 });
                  navigatorKey.currentState!.popUntil((route) => route.isFirst);
            
           });
            }on FirebaseAuthException catch(e)
            {
               navigatorKey.currentState!.popUntil((route) => route.settings.name=='signup');

              print(e);
              

              Working.showSnackBar(e.message,Colors.red);
             
            }
      }
           // navigatorKey.currentState!.popUntil((route) => route.isFirst);
          
 Future<bool> Isadmin(String id) async
{
  bool exist=false;
  await FirebaseFirestore.instance.doc('admin/$id').get().then((doc) {
    exist=doc.exists;
  });
  return exist;
}

//   try{

// dynamic result=_auth.createUserWithEmailAndPassword(email: email, password: password).then((user)
// {
//  // User user=User(result.uid,result.name,result.score);
//    FirebaseFirestore.instance.collection('/user').add({
//     'name':name,
//     'score':0,

//    }).then((value){
//     Navigator.of(context).pop();
//     Navigator.of(context).pushReplacementNamed('home');
//    }).catchError((e){
//     print(e);
//    });
// });
//  }catch(e){
//   print(e.toString());
//   return null;
//  }
  //}
}
