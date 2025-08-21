import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/entities/settings/brightness_mode_entity.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/cubits/cubit/settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoaded) {
            final isDark = state.brightnessMode == BrightnessModeEntity.dark;

            return ListTile(
              title: const Text("Dark Mode"),
              trailing: Switch(
                value: isDark,
                onChanged: (_) {
                  context.read<SettingsCubit>().toggleBrightness();
                },
              ),
            );
          } else if (state is SettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SettingsError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {

            return const Center(child: Text("Loading settings..."));
          }
        },
      ),
    );
  }
}
