import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  final _favoriteWordPairs = <WordPair>{};

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext context, int index) {
        if (index.isOdd) return const Divider();

        if ((index >= _randomWordPairs.length)) {
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        index = index ~/ 2;

        return _buildRow(_randomWordPairs[index]);
      },
    );
  }

  Widget _buildRow(WordPair wordPair) {
    final alreadySave = _favoriteWordPairs.contains(wordPair);

    var rowText = Text(
      wordPair.asPascalCase,
      style: const TextStyle(fontSize: 24),
    );

    var rowIcon = const Icon(Icons.star_border_outlined);
    if (alreadySave) {
      rowIcon = const Icon(Icons.star, color: Color.fromARGB(255, 239, 133, 5));
    }

    return ListTile(
      title: rowText,
      trailing: rowIcon,
      onTap: () {
        setState(() {
          if (alreadySave) {
            _favoriteWordPairs.remove(wordPair);
          } else {
            _favoriteWordPairs.add(wordPair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBarTitle = "Word Pair Management App";

    return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          actions: <Widget>[
            IconButton(
                onPressed: _pushFavorites, icon: const Icon(Icons.hotel_class))
          ],
        ),
        body: _buildList());
  }

  void _pushFavorites() {
    var newScreen = MaterialPageRoute(builder: (BuildContext buildContext) {
      final Iterable<ListTile> favorites =
          _favoriteWordPairs.map((WordPair wordPair) {
        return ListTile(
          title:
              Text(wordPair.asPascalCase, style: const TextStyle(fontSize: 24)),
        );
      });

      final List<Widget> divided =
          ListTile.divideTiles(tiles: favorites, context: buildContext)
              .toList();

      return Scaffold(
          appBar: AppBar(
            title: const Text("Favorites"),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: divided,
          ));
    });

    Navigator.of(context).push(newScreen);
  }
}
