import 'package:flash_cards_project/flashcards_app/features/domain/entities/deck_entity.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/entities/flashcard_entity.dart';

abstract class DecksRepository {
  Future<void> deleteDeck(String id);
  Future<List<DeckEntity>> getAllDecks();
  Future<DeckEntity?> getDeck(String id);
  Future<void> addDeck(DeckEntity deck);
  Future<void> addFlashcardToDeck(String deckId, FlashcardEntity flashcard);
  Future<void> deleteFlashcardFromDeck(String deckId, String flashcardId);
}