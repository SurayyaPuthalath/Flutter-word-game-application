//import 'dart:ffi';


// import 'package:audioplayer/audioplayer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fool_game_project/screens/authenticate/login.dart';
import 'package:fool_game_project/screens/home/dashboard.dart';
import 'package:fool_game_project/screens/home/working.dart';
import 'gamepage.dart';


class RandomWord {
  final String word;
  final bool IsEasy;
  RandomWord({required this.word, required this.IsEasy});
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  var userRef = FirebaseFirestore.instance.collection('user');

  // final AudioPlayer player= AudioPlayer();
  late AudioCache _audioCache;

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
     print(Username);
      _audioCache = AudioCache(prefix: "audio/",);
    
  
    

    
  }
    @override
void dispose() {
  AudioPlayer().dispose();
  super.dispose();
}


   bool on=false;

   Icon music=Icon(Icons.music_off);
 
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    //getNameScore();


   


    return Scaffold(
        appBar: AppBar(
          title:Row(       
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
            TextButton.icon(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login()));
                },
                icon: Icon(Icons.person),
                label: Text('Logout',style: TextStyle(
                  color: Colors.white,
                ),))
          ],
        ),
        body: Center(
          child: Container(
            width: w,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //     colors: [
            //       Color.fromARGB(255, 105, 101, 104),
            //       Color.fromARGB(255, 217, 214, 219)
            //     ],
            //   ),
            // ),
            decoration:const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/main1.jpg"),
            fit: BoxFit.cover,
          )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async{

    Map<String,double> dataMap=await Working().getwinrate();
     Map<String,int> scoreMap=await Working().getRanking();
      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => DashBoard(
                                                dataMap:dataMap,scoreMap:scoreMap)));

  
                    //  Navigator.pushNamed(context, 'dashboard');
                    },
                    child: Text(
                      'DashBoard',
                      style: TextStyle(
                        color: Color.fromARGB(255, 254, 250, 255),
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 51, 50, 114),
                      minimumSize: Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var word = await Working().getWord();
                   
                    print(word);
                    showDialog(
                        context: context,
                        builder: (context) => Center(
                              child: Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width) * 0.3,
                                  height: (MediaQuery.of(context).size.height) *
                                      0.3,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Text(
                                          'Choose Difficulty Level',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) => Game(
                                                      word: word,
                                                      IsEasy: true)));
                                          // Navigator.pushNamed(context, 'gamepage',arguments: RandomWord(word:word,IsEasy:true));
                                        }),
                                        child: Text('Easy'),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(w * 0.1, 30),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) => Game(
                                                      word: word,
                                                      IsEasy: false)));
                                        }),
                                        child: Text('Hard'),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(w * 0.1, 30),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ));
                  },
                  child: Text(
                    'Play',
                    style: TextStyle(
                      color: Color.fromARGB(255, 236, 227, 238),
                      fontSize: 20,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 51, 50, 114),
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        
        )
      ,
      floatingActionButton: FloatingActionButton(
        child:music,
        onPressed: (){
          on=!on;
          print(on);

          if(on==true)
          {
             AudioPlayer().play(AssetSource('audio/bgm.mp3'));


              
             
            setState(() {
              music=Icon(Icons.music_note);
             
            });
            
          }
          else{
            setState(() {
              music=Icon(Icons.music_off);
          

            });
            AudioPlayer().stop();
            _audioCache.clearAll();
             
         
          }

          

       
       
          


            
         
         

  

      
        
       
      },
      backgroundColor: Color.fromARGB(255, 51, 50, 114),

      

      ),
      );
  }
}
