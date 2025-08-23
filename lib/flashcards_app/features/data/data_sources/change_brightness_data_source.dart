import 'package:flash_cards_project/flashcards_app/features/data/models/brightness_mode_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ChangeBrightnessDataSource {
  Future<BrightnessModeModel?> getBrightness();
  Future<void> setBrightness(BrightnessModeModel mode);
}

class ChangeBrightnessDataSourceImp implements ChangeBrightnessDataSource{
  final Box<BrightnessModeModel> modeBox;
  final String key = 'brightnessMode';
  ChangeBrightnessDataSourceImp({required this.modeBox});
  

  @override
  Future<BrightnessModeModel?> getBrightness()async {
    return modeBox.get(key);
  }

  @override
  Future<void> setBrightness(BrightnessModeModel mode) async{
    await modeBox.put(key, mode);
  }
  
}