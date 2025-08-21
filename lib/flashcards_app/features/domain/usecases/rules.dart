

import 'package:flash_cards_project/flashcards_app/features/domain/entities/flashcard_entity.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/repositories/flashcard_repository.dart';

class AddFlashcard{
  final FlashcardRepository repo;
  AddFlashcard(this.repo);

  Future<void> call(FlashcardEntity flashcard)async{
    await repo.addFlashcard(flashcard);
  }
}


class DeleteFlashcard {
  final FlashcardRepository repo;
  DeleteFlashcard(this.repo);

  Future<void> call(String id) async {
    await repo.deleteFlashcard(id);
  }
}


class GetAllFlashcards{
  final FlashcardRepository repo;
  GetAllFlashcards(this.repo);

  Future<List<FlashcardEntity>> call()async{
    return repo.getAllFlashcards();
  }
}