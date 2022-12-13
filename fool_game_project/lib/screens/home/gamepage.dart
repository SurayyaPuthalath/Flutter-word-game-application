
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fool_game_project/main.dart';
import 'package:fool_game_project/models/word.dart';
import 'package:fool_game_project/screens/home/home.dart';
import 'package:fool_game_project/screens/home/working.dart';
import 'package:fool_game_project/models/Word.dart';
import 'package:fool_game_project/screens/ui.dart';
import 'dart:async';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Game extends StatefulWidget {
  final String word;
  final bool IsEasy;
  Game({required this.word, required this.IsEasy, super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int move = 0;
  bool hidden = false;
  var letterMap = new Map();
  bool flag=false;
  // static
  // static String word='hello';

  List<String> checklist = [];

  List<String> letters = [];
//=word.toUpperCase().split('');
  Working wobj = Working();
  List<String> selected = [];

  List<String> alphabets = [
    "Q",
    "W",
    "E",
    "R",
    "T",
    "Y",
    "U",
    "I",
    "O",
    "P",
    "A",
    "S",
    "D",
    "F",
    "G",
    "H",
    "J",
    "K",
    "L",
    "Z",
    "X",
    "C",
    "V",
    "B",
    "N",
    "M",
  ];
  dynamic _start = 60;
  Timer? _timer;
  bool isTimeover=false;
  String category='';
  String description='';
 

void startTimer() {
  const oneSec = Duration(seconds: 1);
  _timer = Timer.periodic( oneSec,
    (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          isTimeover=true;
          
        });
      } else {
        setState(() {
          _start--;
        });
      }
    },
  );
}

  @override
  void initState() {
   
    // late Future<Word> futureWord;
    //     futureWord =wobj.fetchWord();
    //     String selectedword='';
    //     futureWord.then((value){
    //       print(value);
    //     selectedword=value.word;
    //     print(selectedword);});
    String word = widget.word;
      isTimeover=false;
    if(widget.IsEasy==false)
    {
      startTimer();
    }
    else{
      _start='';
    }
  

    // getRandomWord();
    print(word);
    letters = word.toUpperCase().split('');
    print(letters);

    checklist.clear();
    for (var i in letters) {
      letterMap[i] = false;

      print(letterMap[i]);
    }
    print('$word in initialize');
    super.initState();
  }
  @override
void dispose() {
  _timer!.cancel();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    Future.delayed(Duration.zero,(() {
      if(isTimeover)
    
   {
    Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return UI().getDialog(
                                    'GAME OVER', Colors.red, '', context,widget.IsEasy,false,'Retry');
                              });
                              isTimeover=false;

   }
    }));
   
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        centerTitle: true,

        backgroundColor:const Color.fromARGB(255, 44, 3, 44),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 60),
      
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UI.getTimerIcon(widget.IsEasy),
                 Text('$_start',style:const TextStyle(
               fontSize: 20,
               color: Colors.white,
               fontWeight: FontWeight.bold,
                ),),

              ],
            ),
          ),

          
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0),
            child: Text(
              'Moves: $move/9',
              style:const TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/pexels-fwstudio-129731.jpg"),
            fit: BoxFit.cover,
          )),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              height: h * 0.3,
              child: Working.getImage(move),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: letters.map((e) {
                  return Container(
                    height: 55,
                    


                    width: 40,
                    padding: EdgeInsets.all(6.0),


              
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Visibility(
                      visible: letterMap[e],
                      child: Text(
                        e.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,

                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Container(
              height: h * 0.15,
              

              child: Column(children: [
               SizedBox(height: 10,),
                UI().showHint(category,true),
                SizedBox(height: 10,),
               UI().showHint(description,false),

              ]),
            
              ),
            Container(
              width: w,
              height: h * 0.5,
              child: GridView.count(
                crossAxisCount: 7,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                padding: EdgeInsets.all(10.0),
                children: alphabets.map((e) {
                  return TextButton(
                    onPressed: ()async{

                    
                      if (letters.contains(e)) {
                        setState(() {
                          letterMap[e] = true;
                        });
                        if (wobj.checkWin(letterMap)) {
                          
                          
                          // var score = await wobj.getScore();

                          setState(() {
                            Navigator.pop(context);
          
                            showDialog(
                              barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return WillPopScope(child:UI().getDialog(
                                    'WON', Colors.green,10, context,widget.IsEasy,true,'Play again'), onWillPop:() async=>false);
                                });


                                 
                          });

                          await wobj.updateScore();

                        }
                      } else if (!selected.contains(e)) {
                        setState(() {
                          move++;
                          });
                            if (move == 9) {
                              Navigator.pop(context);
                          showDialog(
                            barrierDismissible: true,
                              context: context,
                              builder: (context) {
                                return WillPopScope(child:UI().getDialog(
                                    'GAME OVER', Colors.red, '', context,widget.IsEasy,false,'Retry'), onWillPop:() async=>false);
                              
                               });
                                
                              await wobj.updatefailure();
                        
                      }
                      
                        
                      }
                          selected.add(e);
                    },
                    child: Text(
                      e,
                      style: TextStyle(
                          fontSize: 15,

                          color: Color.fromARGB(255, 114, 14, 114)),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: wobj.setColor(e, letters, selected),
                      // minimumSize: Size(40,50),



                    ),
                  );
                }).toList(),
              ),
            ),
          ]),
        ),
      ),
     floatingActionButton:SpeedDial(
      backgroundColor: Colors.amber,
      icon: Icons.lightbulb,
      children: [
        SpeedDialChild(
          child: Icon(Icons.abc),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          label: 'Letter',
          onTap: () async {
            if(flag==false)
            {
               String a=await wobj.getHint(widget.word,true,false,false);
            
                  
            print(a);
            setState(() {
              if(letterMap[a.toUpperCase()]==true)
              {
                       for (var k in letterMap.keys) {
                       if(letterMap[k]==false)
                       {
                        letterMap[k]=true;
                         checklist.add(k.toUpperCase());
                         selected.add(k);
                         print(selected);
                         
                        break;
                       }
             }
              }
              else{
                letterMap[a.toUpperCase()]=true;
              checklist.add(a.toUpperCase());
              selected.add(a);
              print(selected);
              
              

              }
              
                
            });

            }
           
            flag=true;
          },
        ),
           SpeedDialChild(
          child: Icon(Icons.category),
          label: 'Category',
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onTap: ()async{
            String hint=await wobj.getHint(widget.word,false,true,false);
            setState(() {
              category=hint;
            });
          }
        ),
        SpeedDialChild(
          child: Icon(Icons.description),
          label: 'Description',
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onTap: () async{
            String hint=await wobj.getHint(widget.word,false,false,true);
            setState(() {
              description=hint;
            });
          },
        ),

      ],
     ),
    );
  }
}
