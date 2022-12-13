import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fool_game_project/screens/home/working.dart';
import 'package:fool_game_project/screens/home/gamepage.dart';

class UI {
 
  Widget getDialog(String text, Color color, var score, BuildContext context,bool IsEasy,bool iswin,String retry) {
     final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    Working wobj = Working();
    return Center(
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          width: w * 0.5,
          height: h * 0.3,
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 10,
            ),
             getwidget(h,iswin,score),
            
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                      onPressed: (() {
                      //  Navigator.popUntil(context, (route) => route.settings.name=='home');
                    //  Navigator.popAndPushNamed(context, 'home');
                         Navigator.pushNamedAndRemoveUntil(
                            context, 'home', (route) => false);

                      }),
                      icon: Icon(Icons.home),
                      label: Text('Home')),
                  ElevatedButton.icon(
                      onPressed: () async {
                        var word = await wobj.getWord();
                        var count=0;

                        // Navigator.popUntil(context, (route){
                        //   return count++==2;
                        //   });
                      
                       
                       Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (builder) =>
                                    Game(word: word, IsEasy: IsEasy) ));
                       
                      },
                      icon: Icon(Icons.autorenew),
                      label: Text(retry))
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget getwidget(var h,bool iswin,var score)
  {
    if(iswin)
    {
       return 
    Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(
                  '$score',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                Image.asset(
                  'assets/images/coin.png',
                  height: h * 0.1,
                ),
              ],
            );

    }
    else{
      return Center(child: Text('Better luck next time',style: TextStyle(color: Colors.red),));
    }
   
  }
 static Widget getTimerIcon(bool IsEasy)
  {
    if(IsEasy)
    {
      return Center();
    }
    else{
      return Icon(Icons.alarm);
    }

  }
  Widget showHint(String hint,bool isCategory)
  {
    if(isCategory)
    {
      return  Text('Category:$hint',style:const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 21, 29, 114),
                ),);

    }
    else
    {
       return  Text('Description:$hint',style:const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 9, 11, 105),
                ),);
    }
    
  }
}
