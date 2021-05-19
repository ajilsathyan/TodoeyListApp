class Task {
  String taskTitle;
  bool isDone;
  Task({this.taskTitle, this.isDone = false});

  void change() {
    isDone = !isDone;
  }
}
