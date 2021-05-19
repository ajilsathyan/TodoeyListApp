import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todey_app/models/task_data_provider.dart';

class TaskScreen extends StatefulWidget {
  static const String id = "task-screen";
  const TaskScreen({Key key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var listTiles = Provider.of<TaskDataProvider>(context).listTiles;
    var functions = Provider.of<TaskDataProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.list,
                  color: Theme.of(context).primaryColor,
                  size: 40,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Todoey",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "${listTiles.length.toString()} Tasks",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView.builder(
                    itemCount: listTiles.length,
                    itemBuilder: (context, index) {
                      return ListTileTask(
                        task: listTiles[index].taskTitle,
                        isCheck: (e) {
                          setState(() {
                            listTiles[index].change();
                          });
                        },
                        isLongPress: () {
                          functions.deleteData(listTiles[index]);
                        },
                        check: listTiles[index].isDone,
                      );
                    }),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    color: Color(0xFF757575),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Column(
                        children: [
                          SizedBox(
                            child: Text("Add Task",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)),
                            height: 45,
                          ),
                          TextFormField(
                            controller: controller,
                            textAlign: TextAlign.center,
                            autofocus: true,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white70),
                                  ),
                                  onPressed: () {
                                    functions.addData(
                                        task: controller.text, isDone: false);
                                    setState(() {
                                      controller.text = '';
                                    });
                                    Navigator.pop(context);
                                    print(
                                        "added" + listTiles.length.toString());
                                  },
                                  child: Text(
                                    "Add ",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class ListTileTask extends StatelessWidget {
  final bool check;
  final String task;
  final Function isCheck;
  final Function isLongPress;
  ListTileTask({this.check, this.task, this.isCheck, this.isLongPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: isLongPress,
      title: Text(
        task,
        style: TextStyle(decoration: check ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        value: check,
        onChanged: isCheck,
      ),
    );
  }
}
