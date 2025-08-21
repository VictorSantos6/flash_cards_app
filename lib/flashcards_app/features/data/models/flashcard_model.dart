
import 'package:flash_cards_project/flashcards_app/features/domain/entities/flashcard/flashcard_entity.dart';
import 'package:hive/hive.dart';

part 'flashcard_model.g.dart'; 

@HiveType(typeId: 0)
class FlashcardModel{
  @HiveField(0)
  String question;

  @HiveField(1)
  String answer;

  @HiveField(2)
  String id;

  FlashcardModel({required this.question, required this.answer, required this.id,});

  factory FlashcardModel.fromEntity(FlashcardEntity entities){
    return FlashcardModel(id: entities.id, question: entities.question, answer: entities.answer);
  }

  FlashcardEntity toEntity(){
    return FlashcardEntity(id: id, question: question, answer: answer);
  }

}