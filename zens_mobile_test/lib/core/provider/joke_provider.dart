import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:zens_mobile_test/core/utilities/utilities.dart';

class JokerProvider extends ChangeNotifier {
  JokerProvider() {
    init();
  }
  List<String> unVotedList = [];
  bool isVoting = false;

  void init() {
    _getUnVotedJoke();
  }

  Future<void> voted() async {
    if (isVoting) return;
    isVoting = true;

    unVotedList = [...unVotedList];
    final voted = unVotedList.removeAt(0);

    notifyListeners();

    final votedJokesPref = Preferences.getString(StringUtils.votedJoke);
    final votedJokes = List<String>.from(jsonDecode(votedJokesPref ?? '[]'));
    votedJokes.add(voted);

    await Preferences.setString(
      StringUtils.votedJoke,
      jsonEncode(votedJokes),
    );

    isVoting = false;
  }

  Future<void> _getUnVotedJoke() async {
    final votedJokesPref = Preferences.getString(StringUtils.votedJoke);
    if (votedJokesPref?.isNotEmpty ?? false) {
      final votedJokes = List<String>.from(jsonDecode(votedJokesPref ?? '[]'));
      JokeUtils.jokesContent.removeWhere(
        (element) => votedJokes.contains(element),
      );
    }

    unVotedList = JokeUtils.jokesContent;
    notifyListeners();
  }
}
