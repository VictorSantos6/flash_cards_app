import 'package:flash_cards_project/flashcards_app/features/domain/entities/flashcard_entity.dart';
import 'package:uuid/uuid.dart';

class DeckEntity {
  List<FlashcardEntity> deck;
  final String id;
  final String name;
  DeckEntity({required this.deck,required this.name, required this.id});
}