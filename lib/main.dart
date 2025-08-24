import 'package:flash_cards_project/flashcards_app/features/data/data_sources/change_brightness_data_source.dart';
import 'package:flash_cards_project/flashcards_app/features/data/data_sources/deck_data_source.dart';
import 'package:flash_cards_project/flashcards_app/features/data/data_sources/flashcard_data_sources.dart';
import 'package:flash_cards_project/flashcards_app/features/data/models/brightness_mode_model.dart';
import 'package:flash_cards_project/flashcards_app/features/data/models/deck_model.dart';
import 'package:flash_cards_project/flashcards_app/features/data/models/flashcard_model.dart';
import 'package:flash_cards_project/flashcards_app/features/data/repository/brightness_mode_repository_imp.dart';
import 'package:flash_cards_project/flashcards_app/features/data/repository/deck_repository_imp.dart';
import 'package:flash_cards_project/flashcards_app/features/data/repository/flashcard_repository_imp.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/entities/brightness_mode_entity.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/usecases/rules.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/cubits/cubit/deck_cubit.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/cubits/cubit/flashcard_cubit.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/cubits/cubit/settings_cubit.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/pages/decks_page.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/pages/flashcards_page.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/pages/home_screen.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(FlashcardModelAdapter());
  Hive.registerAdapter(BrightnessModeModelAdapter());
  Hive.registerAdapter(DeckModelAdapter());

  final userBox = await Hive.openBox<FlashcardModel>("flashcards");
  final settingsBox = await Hive.openBox<BrightnessModeModel>("settings");
  final deckBox = await Hive.openBox<DeckModel>("Decks");

  final flashcardDS = FlashcardDataSourcesImp(userBox);
  final repo = FlashcardRepositoryImp(dataSource: flashcardDS);

  final brightnessDS = ChangeBrightnessDataSourceImp(modeBox: settingsBox);
  final brightnessRepo = BrightnessModeRepositoryImp(dataSourceImp: brightnessDS);

  final deckDS = DeckDataSourceImp(deckBox: deckBox);
  final deckRepo = DeckRepositoryImp(dataSourceImp: deckDS);

  // final addFlashcardUC = AddFlashcard(repo);
  // final deleteFlashcardUC = DeleteFlashcard(repo);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SettingsCubit(brightnessRepo)
        ),
        BlocProvider(
          create: (_) => DeckCubit(repo: deckRepo)
        )
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          Brightness brightness = Brightness.light;
          if (state is SettingsLoaded) {
            brightness = state.brightnessMode == BrightnessModeEntity.dark ? Brightness.dark : Brightness.light;
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(brightness: brightness),
            routes: {
              '/': (context) => HomeScreen(),
              'DP': (context) => DecksPage(),
              'SP': (context) => SettingsPage(),
            },
          );
        },
      ),
    ),
  );
}
