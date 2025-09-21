import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:testmodal/database.dart';
import 'package:testmodal/todo_item.dart';

void main() {
  sqfliteFfiInit();
  databaseFactoryOrNull = databaseFactoryFfi;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ModalListDemo(),
    );
  }
}

class ModalListDemo extends StatefulWidget {

  const ModalListDemo({super.key});

  @override
  ModalListDemoState createState() => ModalListDemoState();
}

class ModalListDemoState extends State<ModalListDemo> {
  List<Task> items = [];
  DataBaseWorks dataBaseWorks = DataBaseWorks();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final result = await dataBaseWorks.getTasks();
    setState(() {
      items = result;
    });
  }

  void showTextInputDialog() async {
    TextEditingController controllers = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter a value'),
          content: TextField(
            controller: controllers,
            decoration: InputDecoration(hintText: 'Type something...'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controllers.text); // OK
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    if (result != null && result
        .trim()
        .isNotEmpty) {
      setState(() {
        items.add(Task(text: result.trim(), isDone: false));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Input List')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.note),
            trailing: items[index].isDone ? Icon(Icons.done) : Icon(Icons.square_outlined),
            title: Text(items[index].text),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showTextInputDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
