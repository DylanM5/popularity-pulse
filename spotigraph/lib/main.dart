import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'spotify_api.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        brightness: Brightness.dark,
        // Define your dark color scheme here
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF121212), // Primary color
          secondary: Color(0xFF1F1B24), // Secondary color
          error: Color(0xFF90EE90), // Accent color (error color in this case)
        ),
        // Add more theme properties as needed
      ),
      // Other app configuration
      home: MyHomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Spotigraph',
          style: TextStyle(
            color: Theme.of(context)
                .colorScheme
                .error, // Set the text color to the accent color
          ),
        ),
      ),
      // Implement the rest of home page widget here
      body: Container(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _searchQuery = 'initial value';
  List<dynamic> _artists = [];

  void _performSearch() async {
    if (_searchQuery.isNotEmpty) {
      // Check if search query is not empty
      try {
        // Make the API call
        final spotifyApi = SpotifyApi();
        final artists = await spotifyApi.searchArtist(_searchQuery);
        setState(() {
          _artists = artists;
        });
      } catch (e) {
        print('Failed to search for artist: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popularity Pulse'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              onEditingComplete: _performSearch,
              decoration: InputDecoration(
                labelText: 'Search for an artist',
                suffixIcon: IconButton(
                  onPressed: _performSearch,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _artists.length,
              itemBuilder: (context, index) {
                final artist = _artists[index];
                return ListTile(
                  title: Text(artist['name']),
                  // Customize the display of artist details as needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
