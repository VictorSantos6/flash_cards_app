part of 'flashcard_cubit.dart';

abstract class FlashcardState{}

class FlashcardInitial extends FlashcardState{}

class FlashcardLoading extends FlashcardState{}

class FlashcardLoaded extends FlashcardState{
  final List<FlashcardEntity> flashcards;
  FlashcardLoaded(this.flashcards);
}

class FlashcardError extends FlashcardState{
  final String message;
  FlashcardError(this.message);
}

