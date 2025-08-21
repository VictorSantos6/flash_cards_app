import 'package:flash_cards_project/flashcards_app/features/data/data_sources/flashcard_data_sources.dart';
import 'package:flash_cards_project/flashcards_app/features/data/models/flashcard_model.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/entities/flashcard_entity.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/repositories/flashcard_repository.dart';

class FlashcardRepositoryImp implements FlashcardRepository{
  final FlashcardDataSourcesImp dataSource;
  FlashcardRepositoryImp({required this.dataSource});
  @override
  Future<void> addFlashcard(FlashcardEntity flashcard)async{
    final model = FlashcardModel.fromEntity(flashcard);
    await dataSource.addFlashcard(model);
  }

  @override
  Future<void> deleteFlashcard(String id) async {
    await dataSource.deleteFlashcard(id);
  }

  @override
  Future<List<FlashcardEntity>> getAllFlashcards()async {
    final model = await dataSource.getAllFlashcards();
    return model.map((m)=> m.toEntity()).toList();

  }

}