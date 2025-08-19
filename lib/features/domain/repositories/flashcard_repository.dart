
import 'package:flash_cards_project/features/domain/repositories/flashcard_entity.dart';

abstract class FlashcardRepository {
  Future<void> addFlashcard(FlashcardEntity card);
  Future<void> deleteFlashcard(String id);
  Future<List<FlashcardEntity>> getFlashcards();
}