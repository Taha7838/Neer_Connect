// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {

  final List<Map<String, dynamic>> waterOptions = [
    {"text":"Hot Water", "Color":Colors.red,},
    {"text":"Cold Water", "Color":Colors.blue,},
    {"text":"Ice Cubes", "Color":Colors.lightBlue,},
    {"text":"Normal Water", "Color":Colors.blueAccent,},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEER CONNECT'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: 450,
            height: 500,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: waterOptions.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: waterOptions[index]['Color'],
                  height: 400,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(waterOptions[index]['text']),
                      SizedBox(height: 200,),
                      ElevatedButton.icon(
                        onPressed: () {}, 
                        label: Text("Add to Cart",
                        
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        ),
                        icon: Icon(Icons.add_shopping_cart_outlined,color: Colors.blue,),
                        iconAlignment: IconAlignment.end,
                      
                      )
                
                    ],
                  ),
                ),
              ), 
            ),
          ),
        ),
      ),
    );
  }
}