import 'package:flutter/material.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  Widget build(BuildContext context) {

    return const Scaffold(

        body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ), // CircleAvatar
            title: Text('Rabbil Hasan', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700
            ),), // TextStyle, Text
            subtitle: Text('rabbil@gmail.com', style: TextStyle(
                color: Colors.white
            ),), // TextStyle, Text
            trailing: Icon(Icons.arrow_forward),
            tileColor: Colors.green,
          ) // ListTile
        ],
      ), // Column



    );
  }
}
