import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flash Cards App",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.all(0),
                  width: 150,
                  height: 150,
                  
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: TextButton(onPressed: (){
                    Navigator.of(context).pushNamed('FP');
                  },
                   child: Text("Flashcards",style: TextStyle(color: Colors.black),)),
                ),
                
                Container(
                  margin: EdgeInsets.all(0),
                  width: 150,
                  height: 150,
                  
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: TextButton(onPressed: (){
                    Navigator.of(context).pushNamed('SP');
                  },
                   child: Text("Settings",style: TextStyle(color: Colors.black),)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}