import 'package:flash_cards_project/flashcards_app/features/domain/entities/settings/brightness_mode_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'brightness_mode_model.g.dart';

@HiveType(typeId: 1)
enum BrightnessMode {
  @HiveField(0)
  dark,

  @HiveField(1)
  light,
}


extension BrightnessModeMapper on BrightnessMode {
  BrightnessModeEntity toEntity() {
    switch (this) {
      case BrightnessMode.dark:
        return BrightnessModeEntity.dark;
      case BrightnessMode.light:
        return BrightnessModeEntity.light;
    }
  }
}

extension BrightnessModeEntityMapper on BrightnessModeEntity {
  BrightnessMode toModel() {
    switch (this) {
      case BrightnessModeEntity.dark:
        return BrightnessMode.dark;
      case BrightnessModeEntity.light:
        return BrightnessMode.light;
    }
  }
}
