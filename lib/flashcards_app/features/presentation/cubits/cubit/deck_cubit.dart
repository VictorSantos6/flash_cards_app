import 'package:bloc/bloc.dart';
import 'package:flash_cards_project/flashcards_app/features/data/repository/deck_repository_imp.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/entities/deck_entity.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/entities/flashcard_entity.dart';
part 'deck_state.dart';

class DeckCubit extends Cubit<DeckState> {
  final DeckRepositoryImp repo;
  DeckCubit({required this.repo}) : super(DeckInitial()){
    loadDecks();
  }

  Future<void> loadDecks() async{
    emit(DeckLoading());
    try{
      final deck = await repo.getAllDecks();
      emit(DeckLoaded(deck));
    }catch(e){
      emit(DeckError("Failed to load decks: $e"));
    }
  }

   Future<void> addDeck(DeckEntity newDeck) async {
    emit(DeckLoading());
    try {
      await repo.addDeck(newDeck);
      final decks = await repo.getAllDecks();

      emit(DeckLoaded(decks));
    } catch (e) {
      emit(DeckError("Failed to add deck: $e"));
    }
  }
  Future<void> deleteDeck(String id) async {
    emit(DeckLoading());
    try {
      await repo.deleteDeck(id);
      final decks = await repo.getAllDecks();

      emit(DeckLoaded(decks));
    } catch (e) {
      emit(DeckError("Failed to delete deck: $e"));
    }
  }

   Future<void> addFlashcard(String deckId, FlashcardEntity flashcard) async {
    emit(DeckLoading());
    try {
      await repo.addFlashcardToDeck(deckId, flashcard);
      final decks = await repo.getAllDecks();
      emit(DeckLoaded(decks));
    } catch (e) {
      emit(DeckError("Failed to add flashcard: $e"));
    }
  }

  Future<void> deleteFlashcard(String deckId, String flashcardId) async {
    emit(DeckLoading());
    try {
      await repo.deleteFlashcardFromDeck(deckId, flashcardId);
      final decks = await repo.getAllDecks();
      emit(DeckLoaded(decks));
    } catch (e) {
      emit(DeckError("Failed to delete flashcard: $e"));
    }
  }
}
