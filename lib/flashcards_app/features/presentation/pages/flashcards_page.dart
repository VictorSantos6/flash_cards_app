
import 'package:flash_cards_project/flashcards_app/features/domain/entities/flashcard_entity.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/cubit/flashcard_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class FlashcardsPage extends StatefulWidget {
  const FlashcardsPage({super.key});

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
          IconButton(onPressed: (){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Text("Add User"),
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
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text("Cancel")
                  ),
                  TextButton(onPressed: (){
                    final question = questionController.text;
                    final answer = answerController.text;

                    final id = Uuid().v4();
                    final flashcard = FlashcardEntity(id: id, question: question, answer: answer);
                    context.read<FlashcardCubit>().addFlashcard(flashcard);

                    answerController.clear();
                    questionController.clear();
                    Navigator.of(context).pop();

                  }, child: (Text("Ok")))
                ],
              );
            });
          }, icon: Icon(Icons.add))
        ],
      ),
      body: BlocBuilder<FlashcardCubit, FlashcardState>(
        builder: (context, state) {
          if(state is FlashcardLoaded){
            if(state.flashcards.isEmpty){
              return const Center(
                child: Text(
                  'No flashcards yet',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.flashcards.length,
              itemBuilder: (context, index) {
                final flashcard = state.flashcards[index];
                return GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder:(context) {
                      return AlertDialog(
                        title: Text("Answer",style: TextStyle(fontWeight: FontWeight.bold),),
                        content: Text(flashcard.answer),
                        actions: [
                          IconButton(onPressed: (){
                            context.read<FlashcardCubit>().deleteFlashcard(flashcard.id);
                          }, icon: Icon(Icons.delete)),
                          TextButton(onPressed: (){Navigator.pop(context);}, child: Text("close"))
                        ],
                      );
                    },);
                  },
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        flashcard.question,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  
                );
              },
            );
          } else if(state is FlashcardLoading){
            return const Center(child: CircularProgressIndicator(),);
          }else{
            return const Center(child: Text("Something went wrong",style: TextStyle(color: Colors.white),),);
          }
        },
      )
      
    );
  }
}