import 'package:bloc/bloc.dart';
import 'package:flash_cards_project/flashcards_app/features/data/repository/flashcard_repository_imp.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/entities/flashcard/flashcard_entity.dart';

import 'package:flash_cards_project/flashcards_app/features/domain/usecases/rules.dart';


part 'flashcard_state.dart';

class FlashcardCubit extends Cubit<FlashcardState> {
  final FlashcardRepositoryImp repo;
  final AddFlashcard addFlashcardUC;
  final DeleteFlashcard deleteFlashcardUC;
  
  FlashcardCubit(this.repo, this.addFlashcardUC, this.deleteFlashcardUC) : super(FlashcardInitial()){
    loadFlashcards();
  }

  Future<void> loadFlashcards()async{
    emit(FlashcardLoading());
    try{
      final flashcards = await repo.getAllFlashcards();
      emit(FlashcardLoaded(flashcards));
    }catch(e){
      emit(FlashcardError("Failed to load flashcards"));
    }
  }

  Future<void> addFlashcard(FlashcardEntity flashcard)async{
    try{
      await addFlashcardUC(flashcard);
      await loadFlashcards();
    }catch(e){
      emit(FlashcardError("Failed to add flashcard: $e"));
    }
  }
    Future<void> deleteFlashcard(String id)async{
    try{
      await deleteFlashcardUC(id);
      await loadFlashcards();
    }catch(e){
      emit(FlashcardError("Failed to delete flashcard: $e"));
    }
  }

}
