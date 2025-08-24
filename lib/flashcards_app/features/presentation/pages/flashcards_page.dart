
import 'package:flash_cards_project/flashcards_app/features/domain/entities/flashcard_entity.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/cubits/cubit/deck_cubit.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class FlashcardsPage extends StatefulWidget {
  final String deckId;
  const FlashcardsPage({super.key,required this.deckId});

  @override
  State<FlashcardsPage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<FlashcardsPage> {
  
  final questionController = TextEditingController();
  final answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcards'),
        actions: [
          IconButton(
            onPressed: (){
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  title: Text(
                    "Add flashcard",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: questionController,
                        decoration: InputDecoration(labelText: "Question: "),
                      ),
                      TextField(
                          controller: answerController,
                          decoration: InputDecoration(labelText: "Answer: "),
                        ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                    child: Text("Cancel",style: TextStyle(color: Colors.amberAccent),)
                    ),
                    TextButton(
                      onPressed: (){
                      final question = questionController.text;
                      final answer = answerController.text;

                      final id = Uuid().v4();
                      final flashcard = FlashcardEntity(id: id, question: question, answer: answer);
                      context.read<DeckCubit>().addFlashcard(widget.deckId,flashcard);

                      answerController.clear();
                      questionController.clear();
                      Navigator.of(context).pop();

                      }, 
                      child: Text("Add",style: TextStyle(color: Colors.amber),)
                    )
                  ],
                );
              }
           );
          }, 
          icon: Icon(Icons.add)
        )
      ],
    ),
      body: BlocBuilder<DeckCubit, DeckState>(
        builder: (context, state) {
          if(state is DeckLoaded){
            final deck = state.decks.firstWhere((d) => d.id == widget.deckId);
            final flashcards = deck.deck;
            if(flashcards.isEmpty){
              return Center(
                child: Text(
                  'No flashcards yet',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return ListView.builder(
              itemCount: flashcards.length,
              itemBuilder: (context, index) {
                final flashcard = flashcards[index];
                return GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder:(context) {
                      return AlertDialog(
                        title: Text("Answer",style: TextStyle(fontWeight: FontWeight.bold),),
                        content: Text(flashcard.answer),
                        actions: [
                          IconButton(
                            onPressed: (){
                              context.read<DeckCubit>().deleteFlashcard(widget.deckId,flashcard.id);
                              Navigator.pop(context);
                            }, 
                            icon: Icon(Icons.delete,color: Colors.red,)),
                            TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              }, 
                            child: Text("close",style: TextStyle(color: Colors.amber),),
                          )
                        ],
                      );
                    },);
                  },
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        flashcard.question,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  
                );
              },
            );
          } else if(state is DeckLoading){
            return Center(
              child: CircularProgressIndicator()
            );
          }else{
            return Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(
                  color: Colors.amber 
                )
              )
            );
          }
        },
      )
    );
  }
}