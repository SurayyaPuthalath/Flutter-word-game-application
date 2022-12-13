import 'package:flutter/material.dart';
import 'package:fool_game_project/screens/home/working.dart';
import 'package:fool_game_project/screens/ui.dart';

class AddWords extends StatefulWidget {
  const AddWords({super.key});

  @override
  State<AddWords> createState() => _AddWordsState();
}

class _AddWordsState extends State<AddWords> {
  final _id=TextEditingController();
   final _word=TextEditingController();
  final _hint=TextEditingController();
    final _category=TextEditingController();
  final _description=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:Center(
              child: Text('ADD WORDS'),
            ),
            backgroundColor: Color.fromARGB(255, 32, 8, 36),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              
            
              child: Form(child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50.0,),
                  TextFormField(
                  controller:_id,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(width: 2,color: Colors.blue)),
                    labelText: 'Id',
                    labelStyle: TextStyle(
                      fontSize: 20.0,

                    )
                    
              


                  ),),
                  SizedBox(height: 30,),
                        TextFormField(
                  controller:_word,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(width: 2,color: Colors.blue)),
                    labelText: 'Word',
                    labelStyle: TextStyle(
                      fontSize: 20.0,

                    )
                    
              


                  ),),
                  SizedBox(height: 20,),
                       TextFormField(
                  controller:_hint,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(width: 2,color: Colors.blue)),
                    labelText: 'Hint Letter',
                    labelStyle: TextStyle(
                      fontSize: 20.0,

                    )
                    
              


                  ),),
                  SizedBox(height: 20,),

                       TextFormField(
                  controller:_category,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(width: 2,color: Colors.blue)),
                    labelText: 'Category',
                    labelStyle: TextStyle(
                      fontSize: 20.0,

                    )
                    
              


                  ),),
                  SizedBox(height: 20,),
                        TextFormField(
                  controller:_description,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(width: 2,color: Colors.blue)),
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      fontSize: 20.0,

                    )
                    
              


                  ),),

                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){
                    Working().storeWords(_id.text.trim(),_word.text.trim(),
                    _hint.text.trim(),_category.text.trim(),_description.text.trim());
                  }, child:Text('Submit'))
        
        
        
                ],
              ),
              ),
             ),
          ),
        )
        
        ,
        
      ),
    );
  }
}

