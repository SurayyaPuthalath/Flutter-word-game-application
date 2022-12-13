import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fool_game_project/screens/home/working.dart';
import 'package:http/http.dart';
import 'package:pie_chart/pie_chart.dart';



class DashBoard extends StatefulWidget {
  // const DashBoard({super.key});
  final Map<String,double> dataMap;
    final Map<String,int> scoreMap;
  DashBoard({required this.dataMap,required this.scoreMap,super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

    // Map<String,double> dataMap={};
    // Map<String,int> scoreMap={};

    final colorList = <Color>[
    Colors.green,
    Colors.red,
  ];
  // getdata() async
  // {
  //   dataMap=await Working().getwinrate();
  //   scoreMap=await Working().getRanking();

  // }



   

 @override
  void initState(){
    // TODO: implement initState
   
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
         //   getdata();
     });
     
      

  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
  }

  
  @override
  Widget build(BuildContext context) {
    
    

    return Scaffold(
      appBar: AppBar(
        title:Center(child: Text('Dashboard')),
        backgroundColor: Color.fromARGB(255, 32, 8, 36),
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
             padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),

        child: Center(
          child: PieChart(
          dataMap:widget.dataMap,
      animationDuration:const Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      ringStrokeWidth: 32,
      centerText: "WINRATE",
      legendOptions:const LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendShape: BoxShape.circle,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,

          ),
      ),
      chartValuesOptions:const ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: true,
          showChartValuesOutside: false,
          decimalPlaces: 1,
      ),
            ),
        ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
          child: Container(
            decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(10),

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
              Text('HIGH SCORE',style: TextStyle(
                fontSize: 30,
              ),),
              SizedBox(height:10.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  
                  Text(widget.scoreMap.keys.elementAt(0).toUpperCase(),style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 27, 70, 29),
                  ),),
                  Text('${widget.scoreMap[widget.scoreMap.keys.elementAt(0)]}',style: 
                  TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 29, 78, 30),
                     fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
            ]),
          ),
        ),
        SizedBox(height: 10.0,),
        Center(child: Text('RANKING',style: TextStyle(
  
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 53, 16, 59),
        ),)),
        SizedBox(height:10.0 ,),
        Container(
          height: 0.8,
          width:(MediaQuery.of(context).size.width)*0.7,
          color: Color.fromARGB(255, 53, 138, 141),

        ),
        SizedBox(height: 10.0,),

        Container(
          child:Expanded(child: ListView.builder(
            itemCount: widget.scoreMap.length,
            itemBuilder:(context, index) {
              String key=widget.scoreMap.keys.elementAt(index);
              return Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 180, 176, 176),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('${index+1}',style: TextStyle(
                          fontSize: 20,
                        ),),
                        Text(key.toUpperCase(), style: TextStyle(
                          
                          fontSize: 20,
              
                        ),),
                        Text('${widget.scoreMap[key]}',style: TextStyle(
                          fontSize: 20,
                        ),),
              
                      ],
                    ),
                  ),
                ),
    
              );
              
            } ),)

        )

      
        ],
      ),

    );
  }

}