import 'package:flash_cards_project/flashcards_app/features/domain/entities/deck_entity.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/cubits/cubit/deck_cubit.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/pages/flashcards_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class DecksPage extends StatefulWidget {
  const DecksPage({super.key});

  @override
  State<DecksPage> createState() => _DecksPageState();
}

class _DecksPageState extends State<DecksPage> {
  final deckName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Decks Page"),
        actions: [
          IconButton(
            onPressed: (){  
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
                            labelText: "Name: "
                          ),
                        )
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel",style: TextStyle(color: Colors.amberAccent),),
                      ),
                      TextButton(
                        onPressed: () {
                          final id = Uuid().v4();
                          final name = deckName.text;
                          final newDeck = DeckEntity(deckList: [], name: name,id: id);
                          context.read<DeckCubit>().addDeck(newDeck);
                          deckName.clear();
                          Navigator.of(context).pop();
                        },
                        child: Text("Add deck",style: TextStyle(color: Colors.amber),),
                      )
                    ],
                  );
                },
              );
            }, 
          icon: Icon(Icons.add),
          ),
        ],

      ),
      body: BlocBuilder<DeckCubit, DeckState>(
        builder: (context, state) {
          if(state is DeckLoaded){
            final decks = state.decks;
            return ListView.builder(
            itemCount: decks.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  title: Text(
                    decks[index].name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FlashcardsPage(deckId: decks[index].id),
                      )
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete,color: Colors.red),
                    onPressed: (){
                      context.read<DeckCubit>().deleteDeck(decks[index].id);
                    },
                  ),
                ),
              );
            }
          );
          } else if(state is DeckLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else{
            return Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(color: Colors.amber),
              ),
              
            );
          }
          
        },
      ),
    );
  }
}
