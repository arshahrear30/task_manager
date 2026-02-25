import 'package:flutter/material.dart';
import 'package:task_manager/ui/widget/profile_summary_card.dart';
import 'package:task_manager/ui/widget/task_item_card.dart';

class CancelledTasksScreen extends StatefulWidget {
  const CancelledTasksScreen({super.key});

  @override
  State<CancelledTasksScreen> createState() => _CancelledTasksScreenState();
}

class _CancelledTasksScreenState extends State<CancelledTasksScreen> {
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
