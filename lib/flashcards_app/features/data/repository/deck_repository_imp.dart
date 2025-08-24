import 'package:flash_cards_project/flashcards_app/features/data/data_sources/deck_data_source.dart';
import 'package:flash_cards_project/flashcards_app/features/data/models/deck_model.dart';
import 'package:flash_cards_project/flashcards_app/features/data/models/flashcard_model.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/entities/deck_entity.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/entities/flashcard_entity.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/repositories/decks_repository.dart';

class DeckRepositoryImp implements DecksRepository{

  DeckDataSourceImp dataSourceImp;

  DeckRepositoryImp({required this.dataSourceImp});

  @override
  Future<void> addDeck(DeckEntity deck) async {
    final model = DeckModel.fromEntity(deck);
    await dataSourceImp.addDeck(model);
  }

  @override
  Future<void> deleteDeck(String id) async {
    await dataSourceImp.deleteDeck(id);
  }

  @override
  Future<List<DeckEntity>> getAllDecks() async {
    final models = await dataSourceImp.getAllDecks();
    return models.map((m)=> m.toEntity()).toList();
  }

  @override
  Future<DeckEntity?> getDeck(String id) async {
    final model = await dataSourceImp.getDeck(id);
    return model?.toEntity();
  }

  @override
  Future<void> addFlashcardToDeck(String deckId, FlashcardEntity flashcard) async {
    final model = FlashcardModel.fromEntity(flashcard);
    await dataSourceImp.addFlashcardToDeck(deckId, model);
  }

  @override
  Future<void> deleteFlashcardFromDeck(String deckId, String flashcardId,) async {
    await dataSourceImp.deleteFlashcardFromDeck(deckId, flashcardId);
  }
}