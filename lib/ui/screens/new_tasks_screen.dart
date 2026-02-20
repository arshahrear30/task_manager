import 'package:flutter/material.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

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
          ), // ListTile



          Row(
            children: [
              SummaryCard() ,// Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
                  child: Column(
                    children: [
                      Text('9', style: Theme.of(context).textTheme.titleLarge,),
                      const Text('New'),
                    ],
                  ), // Column
                ), // Padding
              ) ,// Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
                  child: Column(
                    children: [
                      Text('9', style: Theme.of(context).textTheme.titleLarge,),
                      const Text('New'),
                    ],
                  ), // Column
                ), // Padding
              ) ,// Card
            ],


          ),



        ],
      ), // Column



    );
  }
}

//widget alada korar jonno purber widget key click kore refactor e click korbo and Extract flutter widget
class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
        child: Column(
          children: [
            Text('9', style: Theme.of(context).textTheme.titleLarge,),
            const Text('New'),
          ],
        ), // Column
      ), // Padding
    );
  }
}
