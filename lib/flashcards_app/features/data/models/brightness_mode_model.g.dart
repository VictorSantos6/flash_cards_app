// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brightness_mode_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrightnessModeAdapter extends TypeAdapter<BrightnessMode> {
  @override
  final int typeId = 1;

  @override
  BrightnessMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BrightnessMode.dark;
      case 1:
        return BrightnessMode.light;
      default:
        return BrightnessMode.dark;
    }
  }

  @override
  void write(BinaryWriter writer, BrightnessMode obj) {
    switch (obj) {
      case BrightnessMode.dark:
        writer.writeByte(0);
        break;
      case BrightnessMode.light:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrightnessModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
