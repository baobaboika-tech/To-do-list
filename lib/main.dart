import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ModalListDemo(),
    );
  }
}

class ModalListDemo extends StatefulWidget {
  @override
  _ModalListDemoState createState() => _ModalListDemoState();
}

class _ModalListDemoState extends State<ModalListDemo> {
  List<String> items = [];

  void _showTextInputDialog() async {
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
        items.add(result.trim());
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
            title: Text(items[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showTextInputDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
