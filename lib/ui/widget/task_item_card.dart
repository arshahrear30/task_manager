import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

enum TaskStatus { //enum ekta class er moto but etar set of value acey ..
  New,
  Progress,
  Completed,
  Cancelled,
}


class TaskItemCard extends StatefulWidget {
  const TaskItemCard({
    super.key,
    required this.task,
    required this.onStatusChange,
    required this.showProgress,
  });

  final Task task;
  final VoidCallback onStatusChange; //oi screen ta data input korar por auto refresh howar jonno
  //ete deyr jonno prottekta screen er TaskItemCard er vitor onStatusChanged nia kaz kortey hoibo
  final Function(bool) showProgress; //status change hoiley jatey instant load hoy .



  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
//--
  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);//progress ta true kore dilam ekon load nibey
    final response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatus(widget.task.sId ?? '', status));

    if (response.isSuccess) {
      widget.onStatusChange();
    }
    widget.showProgress(false);
  }
  //--

  //-- cailey same vabey delete task add kortey pari api dia o . kintu akon delete api nai .. HW

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              widget.task.title ?? '',//null hoiley empty dekaibo
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(widget.task.description ?? ''),
            Text('Date : ${widget.task.createdDate}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Chip(
                  label: Text(
                    widget.task.status ?? 'New', // kono kicu nai by default New
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
                Wrap(
                  children: [

                   // IconButton(
                   //     onPressed: () {},
                   //     icon: const Icon(Icons.delete_forever_outlined)),
                    // delete api nai .. tobey HomeWork kortey paro


                    IconButton(onPressed: () {//edit button er maz e ekta modal banacci

                      showUpdateStatusModal();

                    }, icon: const Icon(Icons.edit)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }



  void showUpdateStatusModal() {
    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
      title: Text(e.name), //enum thekey name gula coley asbey

      onTap: () {
        updateTaskStatus(e.name);
        Navigator.pop(context);
      },

    ))
        .toList();

    showDialog(
        context: context,
        builder: (context) {

          return AlertDialog(
            title: const Text('Update status'),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
            ),

            actions: [
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        });
      }


}