import 'package:task_manager/data/models/task.dart';

//post man json file key ei website er maddom e convert korci .
// .https://javiercbk.github.io/json_to_dart/
//listTaskByStatus


class TaskListModel {
  String? status;
  List<Task>? taskList;

  TaskListModel({this.status, this.taskList});

  TaskListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <Task>[];
      json['data'].forEach((v) {
        taskList!.add(Task.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.taskList != null) {
      data['data'] = this.taskList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}