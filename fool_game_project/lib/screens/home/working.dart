import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fool_game_project/models/Word.dart';
import 'dart:convert';

class Working {
  

  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  final user = FirebaseAuth.instance.currentUser;

  var userRef = FirebaseFirestore.instance.collection('user');
 static var wordRef = FirebaseFirestore.instance.collection('words');

  static Widget getImage(int moves) {
    switch (moves) {
      case 1:
        return Image(image: AssetImage("assets/images/fool1.png"));
        break;
      case 2:
        return Image(image: AssetImage("assets/images/fool2.png"));
        break;
      case 3:
        return Image(image: AssetImage("assets/images/fool3.png"));
        break;
      case 4:
        return Image(image: AssetImage("assets/images/fool4.png"));
        break;
      case 5:
        return Image(image: AssetImage("assets/images/fool5.png"));
        break;
      case 6:
        return Image(image: AssetImage("assets/images/fool6.png"));
        break;
      case 7:
        return Image(image: AssetImage("assets/images/fool7.png"));
        break;
      case 8:
        return Image(image: AssetImage("assets/images/fool8.png"));
        break;
      case 9:
        return Image(image: AssetImage("assets/images/fool9.png"));
        break;

      default:
        return Container();
        break;
    }
  }

  static Widget setLetter(String a, bool hidden) {
    return Visibility(
      visible: hidden,
      child: Text(
        a.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 40.0,
        ),
      ),
    );
  }

  Color setColor(String e, List<String> l, List<String> selectedl) {
    if (l.contains(e) && selectedl.contains(e)) {
      return Colors.green;
    } else if (!l.contains(e) && selectedl.contains(e)) {
      return Colors.red;
    }
    return Colors.white;
  }

  static showSnackBar(String? text, Color color) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: color,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }


  bool checkWin(Map<dynamic, dynamic> l) {
    bool flag = true;
    for (var i in l.keys) {
      if (l[i] != true) {
        flag = false;
      }
    }

    return flag;
  }

  Future<void> updateScore() async {
    final document = await userRef.doc(user!.uid).get();

    var currentScore = document.data()!['score'];
    var currentWins= document.data()!['wins'];

    print(currentScore);
    currentScore = currentScore + 10;
    currentWins=currentWins+1;
    print(currentScore);
    print(user!.uid);

    await userRef.doc(user!.uid).update({
      'score': currentScore,
      'wins':currentWins,
    });
  }

  Future updatefailure() async
  {
    final document = await userRef.doc(user!.uid).get();
    var currentfails= document.data()!['failure'];
     currentfails=currentfails+1;
    await userRef.doc(user!.uid).update({
      'failure':currentfails,
    });


  }

  Future<void> storeWords(String id, String word, String letter,
      String category, String description) async {
      
    try {
      await wordRef.doc(id).set({
        'id':int.parse(id),
        'word': word,
        'letter': letter,
        'category': category,
        'description': description
      }).then((value) {
        showSnackBar('data added Succesfully', Colors.green);
      }).catchError((error) {
        showSnackBar("Failed to store data", Colors.red);
      });
    } on FirebaseException catch (e) {
      showSnackBar(e.message, Colors.red);
    }
  }
 

  Future<String> getWord() async {
    var max;
  final doc1=await wordRef.orderBy('id',descending: true).limit(1).get();
  doc1.docs.forEach((element) {
    max=element['id'];
  });

    print(max);
    var r = Random();
    
    int i = r.nextInt(max) + 1;
    print(i);


    String randomWord;
    final doc = await wordRef.doc(i.toString()).get();
    randomWord = doc.data()!['word'];
    return randomWord;
  }

  Future<int> getScore() async {
    
    final doc = await userRef.doc(user!.uid).get();
    print(doc.data()!['score']);
    return doc.data()!['score'];
  }
  
 Future<Map<String,double>> getwinrate()async
  {
   final doc=await userRef.doc(user!.uid).get();
   var win=doc.data()!['wins'].toDouble();
   var failure=(doc.data()!['failure']).toDouble();
   print(failure);
   final Map<String,double> winrate={
    'Wins':win,
    'Failure':failure,
   };
   print(winrate);

    return winrate;


  }

    Future getRanking() async
  {
    Map<String,int> scoreMap={};
    final doc=await FirebaseFirestore.instance.collection('user').orderBy('score',descending: true).get();
   doc.docs.forEach((element) {
    scoreMap[element['name']]=element['score'];
   });
    // then((snapshot){
    //   snapshot.docs.forEach((document) {
    //     print(document['name']);
    //     print(document['score']);
    //    });

    // });
    print(scoreMap);
    return scoreMap;
  }

Future<String> getHint(String word,bool isLetter,bool isCategory,bool isDescription) async
{
  String letter='';
  String category='';
  String description='';
  final doc=await wordRef.where('word',isEqualTo: word).get();
  doc.docs.forEach((element) {
    letter=element['letter'];
    category=element['category'];
    description=element['description'];
  });
  if(isLetter)
  {
      return letter;
  }
  if(isCategory)
  {
    return category;
  }
  if(isDescription)
  {
    return description;
  }
  return '';

}



// https://wordsapiv1.p.mashape.com/words/{word}

// Future<Word> fetchWord() async {
//   final response = await http
//       .get(Uri.parse('https://www.dictionaryapi.com/api/v3/references/sd4/json/baseball?key='));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Word.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load word');
//   }
// }

}
