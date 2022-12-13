
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fool_game_project/models/word.dart';
import 'package:fool_game_project/screens/admin/addwords.dart';
import 'package:fool_game_project/screens/admin/adminhome.dart';
import 'package:fool_game_project/screens/authenticate/Signup.dart';
import 'package:fool_game_project/screens/authenticate/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fool_game_project/screens/authenticate/service.dart';
import 'package:fool_game_project/screens/home/dashboard.dart';
import 'package:fool_game_project/screens/home/gamePage.dart';
import 'package:fool_game_project/screens/home/home.dart';
import 'package:fool_game_project/screens/home/working.dart';

//import 'package:animated_splash_screen/animated_splash_screen.dart';
//import 'package:page_transition/page_transition.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

// FlutterNativeSplash.removeAfter(initialization);

 

  runApp(const MyApp());
}




//  Future initialization(BuildContext? context) async {
//   await Future.delayed(Duration(milliseconds:20));
//   }
final navigatorKey=GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    
    return MaterialApp(
     navigatorKey: navigatorKey,
     scaffoldMessengerKey: Working.messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'FOOL GAME APP',

      initialRoute: 'wrap',
      routes: {
        'wrap':(context)=>Wrapper(),
        'login':(context) => Login(),
        'signup':(context) => SignUp(),
        'home':(context) => HomePage(),
      //  'gamepage':(context) => Game(),
        'adminhome':(context) => AdminHome(),
        'addwords':(context) => AddWords(),
      //  'dashboard':(context) => DashBoard(),

      },
     
 
      home:Wrapper(),
    );
  }
}


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});
  

  @override
  Widget build(BuildContext context) {
       bool exist=false;
    return Scaffold(
            resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
       return Center(child: CircularProgressIndicator());
           }
           else if(snapshot.hasError)
           {
            return Center(child: Text('Something went wrong'),);
           }
           else if(snapshot.hasData)
          {
          
            FirebaseFirestore.instance.doc('admin/${snapshot.data!.uid}').get().then((doc){
              if(doc.exists)
              {
                exist=true;
              }
              
            });
            print(exist);
            
            if(exist)
            {
              return AdminHome();
            }
          
           // final user=snapshot.data;
         return HomePage();
          }
          else{
            return Login();
          }
        
       },
       ) ,
    );
  }
}


