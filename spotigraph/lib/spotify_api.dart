import 'dart:convert';
import 'package:http/http.dart' as http;

class SpotifyApi {
  static const String baseUrl = 'https://api.spotify.com/v1';

  // Search for an artist by providing a query
  Future<List<dynamic>> searchArtist(String query) async {
    final endpoint = '$baseUrl/search?q=$query&type=artist';
    final response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Authorization':
            'Bearer <BQAFsegY0lr8ctbofMeeV6mqurdwhwgUmfAqa9wMGMHVsuKBInyR4yWxYdY0ayFlS1fIZ4yqzPp9Fzf-M55oxfIw11n5QkjlzURsWVX03ex6BtT-lfekN_4wrb-1_X4zQyfWlmBp3hujGz_sjCq8pAFmcP8igowl5Dqi96DCGz7cBJhXKmy3PSKA0O6drHHBvOzM-hnxfA5aa3h9rEu_y61ka9YXZE02YFKyZNX16iJ_HxTgFi_3d6bEbbJy9cc8OUn7lI6kJ1Fupsfe1z4QVkqmS9PQT8dMjgnnCKZiX5ebe0-1nuWSfzK32ZGVWE6qVuhe11ie0S_OfScUec5dSPkwTI74AqH6>',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final artists = data['artists']['items'] as List<dynamic>;
      return artists;
    } else {
      throw Exception('Failed to search for artist: ${response.statusCode}');
    }
  }
}
