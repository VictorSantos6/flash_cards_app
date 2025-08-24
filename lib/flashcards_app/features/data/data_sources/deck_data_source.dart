import 'package:flash_cards_project/flashcards_app/features/data/models/deck_model.dart';
import 'package:flash_cards_project/flashcards_app/features/data/models/flashcard_model.dart';
import 'package:hive_flutter/hive_flutter.dart';


abstract class DeckDataSource {
  Future<void> addDeck(DeckModel deck);
  Future<void> deleteDeck(String id);
  Future<List<DeckModel>> getAllDecks();
  Future<DeckModel?> getDeck(String id);

  Future<void> addFlashcardToDeck(String deckId, FlashcardModel flashcard);
  Future<void> deleteFlashcardFromDeck(String deckId, String flashcardId);
}

class DeckDataSourceImp implements DeckDataSource{
  Box<DeckModel> deckBox;
  DeckDataSourceImp({required this.deckBox});
  @override
  Future<void> addDeck(DeckModel deck) async{
    await deckBox.put(deck.id,deck);
  }

  @override
  Future<void> deleteDeck(String id) async {
    await deckBox.delete(id);
  }

  @override
  Future<List<DeckModel>> getAllDecks() async {
    return deckBox.values.toList();
  }

  @override
  Future<DeckModel?> getDeck(String id) async {
    return deckBox.get(id);
  }

   @override
  Future<void> addFlashcardToDeck(String deckId, FlashcardModel flashcard) async {
    final deck = deckBox.get(deckId);
    if (deck != null) {
      deck.deckModel.add(flashcard); 
      await deckBox.put(deckId, deck);
    }
  }

  @override
  Future<void> deleteFlashcardFromDeck(String deckId,String flashcardId) async {
    final deck = deckBox.get(deckId);
    if (deck != null) {
      deck.deckModel.removeWhere((f) => f.id == flashcardId);
      await deckBox.put(deckId, deck); 
    }
  }
  
}