
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fool_game_project/screens/authenticate/login.dart';

class AdminHome extends StatefulWidget {
 AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
    final user=FirebaseAuth.instance.currentUser;

    
  var userRef = FirebaseFirestore.instance.collection('admin');
  
  String Username='';

  
   Future<String> getName() async{
    String name = '';
     
   final doc=await userRef.doc(user!.uid).get();
   name=doc.data()!['name'];
   print(name);
    return name;
  }

  getname() async
  {
    Username=await getName();
    print(Username);



  }
   @override
  void initState() {
    // TODO: implement initState
     getname();
     super.initState();

  }

 

  @override
  Widget build(BuildContext context) {

    
  


   


    return Scaffold(
      
      appBar: AppBar(
        title: Row(       
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.home),
              ),
              Text(Username.toUpperCase()),
  
            ],
          ),

        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 51, 50, 114),
        actions: [
          TextButton.icon(onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context,MaterialPageRoute(builder:(BuildContext context) => Login() ));
          }, icon: Icon(Icons.person), label:Text('Logout',
          style: TextStyle(
            color: Colors.white,
          ),))
        ],
      ),
      body:Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            
            colors:[Color.fromARGB(255, 105, 101, 104),
                  Color.fromARGB(255, 217, 214, 219),],
          ),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            

            children: [
              // ElevatedButton(onPressed: (){}, child: Text('',style: TextStyle(
              //   color: Color.fromARGB(255, 52, 8, 59),
              //   fontSize: 20,

              // ),),
              // style: ElevatedButton.styleFrom(
              //   backgroundColor: Colors.white,
              //      minimumSize:Size(200,50),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(32.0),
               

              //   ),
              //   )),
              // SizedBox(height: 30,),

              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, 'addwords');
              }, child: Text('Add Words',style: TextStyle(
                color: Colors.white,
                fontSize: 20,

              ),),style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 51, 50, 114),
                   minimumSize:Size(200,50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
               

                ),
                ),


              ),
            ],
          ),
        ),
      )
    );

 
  }

  
}