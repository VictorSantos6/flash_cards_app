import 'package:flash_cards_project/flashcards_app/features/domain/entities/flashcard_entity.dart';

abstract class FlashcardRepository {
  Future<void> addFlashcard(FlashcardEntity flashcard);
  Future<void> deleteFlashcard(String id);
  Future<List<FlashcardEntity>> getAllFlashcards();
}