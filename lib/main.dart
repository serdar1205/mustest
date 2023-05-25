import 'package:flutter/material.dart';
import 'package:mustest/screens/category_selector.dart';
import 'package:mustest/service/hardcoded_playlists_service.dart';
import 'package:mustest/service/playlist_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Provider<PlaylistService>(
        create: (_) => HardcodedPlaylistsService(),
        child: CategorySelector(),
      ),
    );
  }
}
