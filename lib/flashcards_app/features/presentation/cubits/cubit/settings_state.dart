part of 'settings_cubit.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState{}

class SettingsLoading extends SettingsState{}

class SettingsLoaded extends SettingsState{
  final BrightnessModeEntity brightnessMode;
  SettingsLoaded({required this.brightnessMode});
}

class SettingsError extends SettingsState{
  final String message;
  SettingsError({required this.message});

}