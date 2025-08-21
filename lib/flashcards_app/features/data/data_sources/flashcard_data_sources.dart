
import 'package:flash_cards_project/flashcards_app/features/data/models/flashcard_model.dart';

import 'package:hive_flutter/hive_flutter.dart';

abstract class FlashcardDataSources {
  Future<void> addFlashcard(FlashcardModel model);
  Future<void> deleteFlashcard(String id);
  Future<List<FlashcardModel>> getAllFlashcards();
}

class FlashcardDataSourcesImp implements FlashcardDataSources{
  final Box<FlashcardModel> flashcardBox;
  FlashcardDataSourcesImp(this.flashcardBox);


  @override
  Future<void> addFlashcard(FlashcardModel model) async {
    await flashcardBox.put(model.id, model);
  }

  @override
  Future<void> deleteFlashcard(String id) async {
    await flashcardBox.delete(id);
  }

  @override
  Future<List<FlashcardModel>> getAllFlashcards() async{
    return flashcardBox.values.toList();
  }

}