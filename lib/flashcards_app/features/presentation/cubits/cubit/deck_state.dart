part of 'deck_cubit.dart';

abstract class DeckState {}

class DeckInitial extends DeckState{}

class DeckLoading extends DeckState{}


class DeckLoaded extends DeckState{
  final List<DeckEntity> decks;
  DeckLoaded(this.decks);
}

class DeckError extends DeckState{
  final String error;
  DeckError(this.error);
}