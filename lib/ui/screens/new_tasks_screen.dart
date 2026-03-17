import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/screens/new_tasks_screen.dart';
import 'package:task_manager/ui/widget/profile_summary_card.dart';
import 'package:task_manager/ui/widget/summary_card.dart';
import 'package:task_manager/ui/widget/task_item_card.dart';


class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}



  class _NewTasksScreenState extends State<NewTasksScreen> {
  //new code eikhan e likbo.
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewTasksScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),



      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16),
                child: Row(
                  children: [

                    SummaryCard(
                      count: '92',
                      title: 'New',
                    ), // SummaryCard

                    SummaryCard(
                      count: '92',
                      title: 'In progress',
                    ), // SummaryCard

                    SummaryCard(
                      count: '92',
                      title: 'Completed',
                    ), // SummaryCard

                    SummaryCard(
                      count: '92',
                      title: 'Cancelled',
                    ), // SummaryCard

                  ],
                ),
              ),
            ),


            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const TaskItemCard(); // Card
                  }
              ), // ListView.builder
            ), // Expanded

          ],
        ),
      ), // Column
    );
  }
}