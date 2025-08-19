
abstract class FlashcardRepository {
  Future<void> addFlashcard(FlashcardEntity card);
  Future<void> deleteFlashcard(String id);
  Future<List<FlashcardEntity>> getFlashcards();
}