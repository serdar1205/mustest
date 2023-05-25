import 'author.dart';

/// An audio item
class PlaylistItem {
  /// The [Author] of this audio item.
  final Author author;
  /// The title of this audio item.
  final String title;
  /// An Uri at which the audio can be found.
  final Uri artworkUri;
  Uri itemLocation;

  PlaylistItem(this.author, this.title, this.artworkUri, this.itemLocation);
}
