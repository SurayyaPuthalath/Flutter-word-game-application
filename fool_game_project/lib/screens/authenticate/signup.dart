import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fool_game_project/screens/authenticate/service.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final BackendService _auth= BackendService();
      final _nameController=TextEditingController();
  final _emailController=TextEditingController();
    final _passwordController=TextEditingController();
    String msg='';
 
 final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
  double h=MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,      
      body: SingleChildScrollView(
        
        child: Column(
           
          children: [
            
            Container(
              
              width:w,
              height:h*0.2,
              decoration: BoxDecoration(
                image:DecorationImage(image: AssetImage("assets/images/splash.png"),
                fit: BoxFit.cover)

                
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical:0),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  
                  children: [
                   const Padding(
                      padding:  EdgeInsets.only(top:20.0),
                      child: Text('Sign Up',style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 90, 6, 83),
                      ),),
                    ),
                   const SizedBox(height: 30),
                    TextFormField(
                      style: TextStyle(fontSize: 20,),
                      controller:_nameController,
                      autocorrect: false,
                     validator: (value) {
                       if(value!=null)
                       {
                        return value.isEmpty?'Username is required':null;
                       }
                       return null;
                      

                     },
                   
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(width: 2,
                        color: Color.fromARGB(255, 152, 34, 173))
              
              
                      ),
                      
                      
                      hintText: 'Username',
                        
                      hintStyle: TextStyle(
                      fontSize: 20),
                       prefixIcon: Icon(
                  
                        Icons.person,
                        color: Color.fromARGB(255, 87, 84, 84),
                        size: 20,
                        ),
              
                    ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(  
                        style: TextStyle(fontSize: 20,),
                      controller:_emailController,
                      autocorrect: false,
                     validator: ((value) {
                       if(value!=null)
                       {
                        if(value.isEmpty)
                        {
                          return 'Email is required';
                        }else if(!EmailValidator.validate(value))
                        {
                          return 'Enter a valid email';
                        }
                         else{
                          return null;
                         }
                       }
                     }),
                    decoration: InputDecoration(

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(width: 2,
                        color: Color.fromARGB(255, 121, 28, 138))
              
                      ),
                      
                      hintText: 'Email',
                       hintStyle: TextStyle(
                      fontSize: 20),
                       prefixIcon: Icon(
                  
                        Icons.email,
                        color: Color.fromARGB(255, 87, 84, 84),
                        size: 20,
                        ),
              
                    ),
                    ),
                    Text(msg,style: TextStyle(color: Colors.red),),
                    SizedBox(height: 20),
                    TextFormField(
                        style: TextStyle(fontSize: 20,),
                      controller:_passwordController,
                      validator: (value) {
                        if(value!=null)
                       {
                         if(value.isEmpty)
                        {
                          return 'Password is required';
                        }else if(value.length < 6)
                        {
                          return 'Enter atleast 6 character';
                        }
                         else{
                          return null;
                         }
                       
                       }
                      },
                      autocorrect: false,
                   obscureText: true,
                    decoration: InputDecoration(
                      
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(width: 2,
                        color: Color.fromARGB(255, 121, 28, 138))
              
                      ),
                      hintText: 'Password',
                       hintStyle: TextStyle(
                      fontSize: 20),
                      
                       prefixIcon: Icon(
                  
                        Icons.password,
                        color: Color.fromARGB(255, 87, 84, 84),
                        size: 20,
                        ),
              
                    ),
                    ),
                    SizedBox(height:40,),
              
                    ElevatedButton.icon(onPressed: () async {
                      if(_formKey.currentState!.validate())
                      {
                         _auth.signUp(_nameController.text.trim(),_emailController.text.trim(),_passwordController.text.trim(),context);

                      }
                    
                     
                    }, icon:Icon(
                      Icons.login,
                    ), label: Text('Sign Up',style: TextStyle(fontSize: 20),),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(w*0.7,50),
                      backgroundColor: Color.fromARGB(255, 67, 10, 77),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)
                      )
                    ),)
                  ],
                ),
              ),
            ),

        ],)
      ),

    );
  }
}