
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fool_game_project/screens/authenticate/service.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
  
}

class _LoginState extends State<Login> {
  final _emailController=TextEditingController();

  final _passwordController=TextEditingController();
  String msg='';
 late User user;
final BackendService _auth= BackendService(); 

  @override
  void dispose()
  {
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        
        decoration:const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, 
            end: Alignment.bottomRight,
             colors: [Color.fromARGB(255, 21, 235, 188), Color.fromARGB(255, 11, 18, 34)]),
        
          )
          ,
                 child: Container(
                  
                 // color: Colors.white,
                      decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 40.0,vertical: 150.0),
                  
                   child: Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
            
              // add Column
              children: [
                Text('Login',
                style: TextStyle(fontSize: 30.0,
                color: Colors.blue,
                  fontWeight: FontWeight.bold),),
                  SizedBox(height:30.0),
                  Text(msg,style: TextStyle(color: Colors.red),),
                Container(
                       decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email ID',
                
                        ),),
                ),
                SizedBox(height: 20.0),
                


                Container(
                         decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                  child: TextField( 
                    controller: _passwordController,
                    obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Password',
                
                        ),),
                ),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    Container(
                     // color: Colors.white,
                      child: ElevatedButton.icon(onPressed:() async{
  
   _auth.signIn( _emailController.text.trim(),_passwordController.text.trim(),context);
//   try{
// await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(),
//      password:_passwordController.text.trim()).then((value){
//       Navigator.of(context).pushReplacementNamed('home');
//      });
//     //  if(user!=null)
//     //  {
//       // Navigator.of(context).popUntil((route) => route.isFirst);
//       // Navigator.pushReplacement(context,MaterialPageRoute(builder:(BuildContext context) => HomePage() ));
//     //  }
//   }on FirebaseAuthException catch(e)
//   {
//     print(e);
//   }
// //  navigatorKey.currentUser!.popUntil((route) => route.home);
  
},
                           icon: Icon(
                            Icons.login
                           ), label:Text('Login'),
                           style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 19, 82, 134)
                           ),
                           ),
                    ),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 0),

                       child: Container(
                       // color: Colors.white,
                        child: ElevatedButton.icon(onPressed: (){
                          Navigator.pushNamed(context, 'signup');
                        },
                             icon: Icon(
                              Icons.login
                             ), label:Text('Sign Up'),
                             style:ElevatedButton.styleFrom(
                              minimumSize: Size(20,35),






                             ),
                             ),
                    ),
                     ),
                  ],
                )
              ],
            ),
          ),
        ),
                   ),
                 ),
        ),
        
      
    );
    
  }
  

  
}