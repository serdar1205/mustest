
import 'package:mustest/model/author.dart';
import 'package:mustest/model/playlist_item.dart';
import 'package:mustest/service/playlist_service.dart';

class HardcodedPlaylistsService implements PlaylistService{
  final _gameSongs = [
    PlaylistItem(
        Author("Blizzard North", null),
        "Tristram",
        Uri.parse(
            "https://upload.wikimedia.org/wikipedia/en/3/3a/Diablo_Coverart.png"),
        Uri.parse(
            "https://archive.org/download/IGM-V7/IGM%20-%20Vol.%207/25%20Diablo%20-%20Tristram%20%28Blizzard%29.mp3")),
    PlaylistItem(
        Author("Game Freak", null),
        "Cerulean City",
        Uri.parse(
            "https://upload.wikimedia.org/wikipedia/en/f/f1/Bulbasaur_pokemon_red.png"),
        Uri.parse(
            "https://archive.org/download/igm-v8_202101/IGM%20-%20Vol.%208/15%20Pokemon%20Red%20-%20Cerulean%20City%20%28Game%20Freak%29.mp3")),
    PlaylistItem(
        Author("Lucasfilm Games", null),
        "The secret of Monkey Island - Introduction",
        Uri.parse(
            "https://upload.wikimedia.org/wikipedia/en/a/a8/The_Secret_of_Monkey_Island_artwork.jpg"),
        Uri.parse(
            "https://scummbar.com/mi2/MI1-CD/01%20-%20Opening%20Themes%20-%20Introduction.mp3")),
  ];

  @override
  // TODO: implement allItems
  List<PlaylistItem> get allItems => _gameSongs;

  @override
  // TODO: implement itemsByAuthor
  Map<Author, List<PlaylistItem>> get itemsByAuthor => throw UnimplementedError();
}