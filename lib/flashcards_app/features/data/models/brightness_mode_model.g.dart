// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brightness_mode_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrightnessModeAdapter extends TypeAdapter<BrightnessModeModel> {
  @override
  final int typeId = 1;

  @override
  BrightnessModeModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BrightnessModeModel.dark;
      case 1:
        return BrightnessModeModel.light;
      default:
        return BrightnessModeModel.dark;
    }
  }

  @override
  void write(BinaryWriter writer, BrightnessModeModel obj) {
    switch (obj) {
      case BrightnessModeModel.dark:
        writer.writeByte(0);
        break;
      case BrightnessModeModel.light:
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
