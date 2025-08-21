import 'package:flash_cards_project/flashcards_app/features/domain/entities/settings/brightness_mode_entity.dart';


abstract class BrightnessModeRepository {
  Future<BrightnessModeEntity> getBrightness();
  Future<void> setBrightness(BrightnessModeEntity entity);
  
}