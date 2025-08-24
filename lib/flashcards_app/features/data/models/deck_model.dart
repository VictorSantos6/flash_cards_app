

import 'package:flash_cards_project/flashcards_app/features/data/models/flashcard_model.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/entities/deck_entity.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'deck_model.g.dart';

@HiveType(typeId: 3)
class DeckModel {
  @HiveField(0)
  List<FlashcardModel> deck;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final String name;

  DeckModel({required this.deck,required this.name,required this.id});

  factory DeckModel.fromEntity(DeckEntity entity){
    return DeckModel(deck: entity.deck.map((e)=> FlashcardModel.fromEntity(e)).toList(),id: entity.id,name: entity.name);
  }

  DeckEntity toEntity(){
    return DeckEntity(deck: deck.map((e)=> e.toEntity()).toList(),id: id,name: name);
  }

}
