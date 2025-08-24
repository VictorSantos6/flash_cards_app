import 'package:flash_cards_project/flashcards_app/features/domain/entities/flashcard_entity.dart';


class DeckEntity {
  List<FlashcardEntity> deckList;
  final String id;
  final String name;
  DeckEntity({required this.deckList,required this.name, required this.id});
}