import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/widget/profile_summary_card.dart';
import 'package:task_manager/ui/widget/task_item_card.dart';

class ProgressTasksScreen extends StatefulWidget {
  const ProgressTasksScreen({super.key});

  @override
  State<ProgressTasksScreen> createState() => _ProgressTasksScreenState();
}

class _ProgressTasksScreenState extends State<ProgressTasksScreen> {
  bool getProgressTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel(); //atar modde i to amra data gula rakhi


  Future<void> getProgressTaskList() async {
    getProgressTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getProgressTasks); //data gula nia asbey aikhan e
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse!);//data gula  taskListModel e aney rakbey
    }
    getProgressTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }


  @override
  void initState() {
    super.initState();
    getProgressTaskList();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            ProfileSummaryCard(), // ListTile
             Expanded( //screen jokon purata jurey thakbey tokon sob data show korbey

               child: RefreshIndicator(
                 onRefresh: getProgressTaskList, //etar deyar karon e ekon screen er upon er dikey tan diley that mean swap kore tan diley refresh hoibo


                 child: Visibility(
                visible: getProgressTaskInProgress==false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0 ,//empty to hoitey parey tai ? use korci and 0
                    itemBuilder: (context, index) {

                      return  TaskItemCard(
                        task: taskListModel.taskList![index],

                        onStatusChange: () {
                          getProgressTaskList();
                        },


                        showProgress: (inProgress) {
                          getProgressTaskInProgress = inProgress;
                          if (mounted) {
                            setState(() {});
                          }
                        },


                      );
                    }
                ),
                 ),
             ),


             ),
          ],
        ),
      ), // Column
    );
  }

}
