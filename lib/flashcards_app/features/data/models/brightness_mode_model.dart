import 'package:flash_cards_project/flashcards_app/features/domain/entities/brightness_mode_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'brightness_mode_model.g.dart';

@HiveType(typeId: 1)
enum BrightnessModeModel {
  @HiveField(0)
  dark,

  @HiveField(1)
  light,
}


extension PizzaTime on BrightnessModeModel {
  BrightnessModeEntity toEntity() {
    switch (this) {
      case BrightnessModeModel.dark:
        return BrightnessModeEntity.dark;
      case BrightnessModeModel.light:
        return BrightnessModeEntity.light;
    }
  }
}

extension BurritoTime on BrightnessModeEntity {
  BrightnessModeModel toModel() {
    switch (this) {
      case BrightnessModeEntity.dark:
        return BrightnessModeModel.dark;
      case BrightnessModeEntity.light:
        return BrightnessModeModel.light;
    }
  }
}
