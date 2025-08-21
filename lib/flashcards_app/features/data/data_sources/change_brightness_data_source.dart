
import 'package:flash_cards_project/flashcards_app/features/data/models/brightness_mode_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ChangeBrightnessDataSource {
  Future<BrightnessMode?> getBrightness();
  Future<void> setBrightness(BrightnessMode mode);
}

class ChangeBrightnessDataSourceImp implements ChangeBrightnessDataSource{
  final Box<BrightnessMode> modeBox;
  static const String key = 'brightnessMode';
  ChangeBrightnessDataSourceImp({required this.modeBox});
  

  @override
  Future<BrightnessMode?> getBrightness()async {
    return modeBox.get(key);
  }

  @override
  Future<void> setBrightness(BrightnessMode mode) async{
    await modeBox.put(key, mode);
  }
  
}