

import '../model/author.dart';
import '../model/playlist_item.dart';

abstract class PlaylistService{
  List<PlaylistItem> get allItems;
  Map<Author, List<PlaylistItem>> get itemsByAuthor;
}