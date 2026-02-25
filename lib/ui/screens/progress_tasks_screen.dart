import 'package:flutter/material.dart';
import 'package:task_manager/ui/widget/profile_summary_card.dart';
import 'package:task_manager/ui/widget/task_item_card.dart';

class ProgressTasksScreen extends StatefulWidget {
  const ProgressTasksScreen({super.key});

  @override
  State<ProgressTasksScreen> createState() => _ProgressTasksScreenState();
}

class _ProgressTasksScreenState extends State<ProgressTasksScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Column(
        children: [
          ProfileSummaryCard(), // ListTile


          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const TaskItemCard(); // Card
                }
            ), // ListView.builder
          ) // Expanded

        ],
      ), // Column
    );
  }

}
