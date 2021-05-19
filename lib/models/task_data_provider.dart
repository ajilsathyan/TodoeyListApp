import 'package:flutter/foundation.dart';
import 'package:todey_app/models/task_model.dart';

class TaskDataProvider extends ChangeNotifier {
  List<Task> listTiles = [
    // Task(taskTitle: "buy some milk", isDone: false),
    // Task(taskTitle: "buy some milk", isDone: false),
    // Task(taskTitle: "buy some milk", isDone: false),
  ];

  addData({String task, bool isDone}) {
    listTiles.add(Task(taskTitle: task, isDone: isDone));
    notifyListeners();
  }

  deleteData(Task task) {
    listTiles.remove(task);
    notifyListeners();
  }
}
