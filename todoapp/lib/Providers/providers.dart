import 'package:flutter/material.dart';

class TodoList {
  List<String> title;
  List<bool> isdone;

  TodoList({required this.title}) : isdone = List.filled(title.length, false);

  void sync() {
    if (isdone.length != title.length) {
      isdone = List.filled(title.length, false);
    }
  }
}

class Notes {
  final List<String> title;
  final List<String> body;
  Notes({required this.title, required this.body});
}

class Listprovider extends ChangeNotifier {
  List<String> worktitle = ['', ''];

  List<TodoList> alllist = [];

  List<Notes> allnotes = [];
  List<String> notestitle = [];
  List<String> notesbody = [];

  // 0 for all, 1 for completed and 2 for pending
  int filter = 0;
  void setfilter(int value) {
    filter = value;
    notifyListeners();
  }

  List<int> get filteredIndexes {
    if (alllist.isEmpty) {
      return [];
    }
    final todo = alllist.first;
    List<int> list = [];
    for (int i = 0; i < todo.title.length; i++) {
      if (filter == 0) {
        list.add(i);
      } else if (filter == 1 && todo.isdone[i]) {
        list.add(i);
      } else if (filter == 2 && !todo.isdone[i]) {
        list.add(i);
      }
    }
    return list;
  }
  // filteredIndexes becomes [0,2,4]

  void addlist() {
    worktitle.add('');
    notifyListeners();
  }

  void removeworktitle(int index) {
    worktitle.removeAt(index);
    notifyListeners();
  }

  void savetitle(String value, int index) {
    worktitle[index] = value;
  }

  void savelist() {
    if (alllist.isEmpty) {
      alllist.add(TodoList(title: List.from(worktitle)));
    } else {
      final todo = alllist.first;
      todo.title.addAll(worktitle);
      todo.sync();
    }
    worktitle = [''];
    notifyListeners();
  }

  void removeTodo(int index) {
    final todo = alllist.first;
    if (alllist.isNotEmpty && index < todo.title.length) {
      todo.title.removeAt(index);
      todo.sync();
      notifyListeners();
    }
  }

  void removenotes(int index) {
    allnotes.removeAt(index);

    notifyListeners();
  }

  addnotestitle(String value) {
    notestitle.add(value);
  }

  addnotesbody(String value) {
    notesbody.add(value);
  }

  void savenotes() {
    allnotes.add(
      Notes(title: List.from(notestitle), body: List.from(notesbody)),
    );
    notestitle = [];
    notesbody = [];
    notifyListeners();
  }
}
