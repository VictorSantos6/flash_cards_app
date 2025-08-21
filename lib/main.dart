
import 'package:flash_cards_project/flashcards_app/features/data/data_sources/flashcard_data_sources.dart';
import 'package:flash_cards_project/flashcards_app/features/data/models/flashcard_model.dart';
import 'package:flash_cards_project/flashcards_app/features/data/repository/flashcard_repository_imp.dart';
import 'package:flash_cards_project/flashcards_app/features/domain/usecases/rules.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/cubit/flashcard_cubit.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/pages/flashcards_page.dart';
import 'package:flash_cards_project/flashcards_app/features/presentation/pages/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(FlashcardModelAdapter());
  final userBox = await Hive.openBox<FlashcardModel>("flashcards");

  final localDS = FlashcardDataSourcesImp(userBox);
  final repo = FlashcardRepositoryImp(dataSource: localDS);

  final addFlashcardUC = AddFlashcard(repo);
  final deleteFlashcardUC = DeleteFlashcard(repo);


  runApp(
    BlocProvider(
      create: (context) => FlashcardCubit(repo,addFlashcardUC,deleteFlashcardUC),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark),
        routes: {
          '/':(context) => const HomeScreen(),
          'FP':(context)=> const FlashcardsPage(),
        },
      ),
    )
  );
}