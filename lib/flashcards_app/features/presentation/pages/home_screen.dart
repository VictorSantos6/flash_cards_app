// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Flash Cards App",
//           style: TextStyle(
//             fontSize: 50,
//             fontWeight: FontWeight.bold
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsetsGeometry.all(20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(0),
//                   width: 150,
//                   height: 150,
                  
//                   decoration: BoxDecoration(
//                     color: Colors.amber,
//                     borderRadius: BorderRadius.circular(30)
//                   ),
//                   child: TextButton(onPressed: (){
//                     Navigator.of(context).pushNamed('DP');
//                   },
//                    child: Text("Decks",style: TextStyle(color: Colors.black),)),
//                 ),
                
//                 Container(
//                   margin: EdgeInsets.all(0),
//                   width: 150,
//                   height: 150,
                  
//                   decoration: BoxDecoration(
//                     color: Colors.amber,
//                     borderRadius: BorderRadius.circular(30)
//                   ),
//                   child: TextButton(onPressed: (){
//                     Navigator.of(context).pushNamed('SP');
//                   },
//                    child: Text("Settings",style: TextStyle(color: Colors.black),)),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flash_cards_project/flashcards_app/features/domain/entities/deck_entity.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/cubits/cubit/deck_cubit.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/pages/flashcards_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final deckName = TextEditingController();
  final List<Color> cardColors = [
    Colors.pinkAccent,
    Colors.amber,
    Colors.lightBlue,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.orangeAccent,
    Colors.redAccent,
    Colors.cyan,
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flashcards",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'SP');
            },
            icon: Icon(Icons.settings,color: Colors.grey[600],),
          ),
        ],
        
      ),
      body: BlocBuilder<DeckCubit, DeckState>(
        builder: (context, state) {
          if(state is DeckLoaded){
            final decks = state.decks;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 400,
                  height: 80,
                  margin: EdgeInsets.all(30),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    color: Colors.blue,
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Add deck"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: deckName,
                                      decoration: InputDecoration(
                                        labelText: "Name: ",
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: Colors.amberAccent,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      final id = Uuid().v4();
                                      final name = deckName.text;
                                      final newDeck = DeckEntity(
                                        deckList: [],
                                        name: name,
                                        id: id,
                                      );
                                      context.read<DeckCubit>().addDeck(
                                        newDeck,
                                      );
                                      deckName.clear();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Add deck",
                                      style: TextStyle(color: Colors.amber),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          "Create",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      )
                    ),
                  )

                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Decks",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: decks.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                        child: Card(
                          color: cardColors[index % cardColors.length],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                          ),
                          child: ListTile(
                            trailing: IconButton(
                              onPressed: () {
                                context.read<DeckCubit>().deleteDeck(decks[index].id);
                              },
                              icon: Icon(Icons.delete,color: Colors.white,),
                            ),
                            title: Text(
                              decks[index].name,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            subtitle: Text(
                              '${decks[index].deckList.length} cards',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                              ),
                            ),
                            onTap: () {
                               Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => FlashcardsPage(deckId: decks[index].id),
                                )
                              );
                            },
                          ),
                        ),
                      );
                      
                    },
                  ),
                ),
              ],
            );
          }else if(state is DeckLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else{
            return Center(
              child: Text("Something Went wrong"),
            );
          }
          
          
        },
      ),
    );
  }
}