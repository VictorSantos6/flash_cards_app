import 'package:bloc/bloc.dart';

import 'package:flash_cards_project/flashcards_app/features/domain/entities/brightness_mode_entity.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/repositories/brightness_mode_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final BrightnessModeRepository repo;

  SettingsCubit(this.repo) : super(SettingsInitial()){
    loadSettings();
  }

  Future<void> loadSettings() async {
    emit(SettingsLoading());
    try {
      final mode = await repo.getBrightness();
      emit(SettingsLoaded(brightnessMode: mode));
    } catch (e) {
      emit(SettingsError(message: e.toString()));
    }
  }

  Future<void> changeBrightness(BrightnessModeEntity newMode) async {
    emit(SettingsLoading());
    try {
      await repo.setBrightness(newMode);
      emit(SettingsLoaded(brightnessMode: newMode));
    } catch (e) {
      emit(SettingsError(message: e.toString()));
    }
  }

  Future<void> toggleBrightness() async {
    if (state is SettingsLoaded) {
      final current = (state as SettingsLoaded).brightnessMode;
      emit(SettingsLoading());
      try {
        final newMode = current == BrightnessModeEntity.dark ? BrightnessModeEntity.light : BrightnessModeEntity.dark;

        await repo.setBrightness(newMode);
        emit(SettingsLoaded(brightnessMode: newMode));
      } catch (e) {
        emit(SettingsError(message: e.toString()));
      }
    }
  }
}
