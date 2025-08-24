import 'package:flash_cards_project/flashcards_app/features/data/data_sources/change_brightness_data_source.dart';
import 'package:flash_cards_project/flashcards_app/features/data/models/brightness_mode_model.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/entities/brightness_mode_entity.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/repositories/brightness_mode_repository.dart';

class BrightnessModeRepositoryImp implements BrightnessModeRepository{
  final ChangeBrightnessDataSourceImp dataSourceImp;
  BrightnessModeRepositoryImp({required this.dataSourceImp});
  @override
  Future<BrightnessModeEntity> getBrightness() async{
    final stored = await dataSourceImp.getBrightness();
    return (stored ?? BrightnessModeModel.light).toEntity();
  }

  @override
  Future<void> setBrightness(BrightnessModeEntity entity)async {
    await dataSourceImp.setBrightness(entity.toModel());
  }
  
}