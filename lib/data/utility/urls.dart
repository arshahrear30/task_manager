import 'package:task_manager/ui/widget/task_item_card.dart';

class Urls {

  static final String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static final String registration = '&_baseUrl/registration';
  static final String login = '&_baseUrl/login';
  static const String createNewTask = '&_baseUrl/createTask';
  static const String getTaskStatusCount = '&_baseUrl/TaskStatusCount';
  static String getNewTasks = '$_baseUrl/listTaskByStatus/${TaskStatus.New.name}';
  static String getProgressTasks = '$_baseUrl/listTaskByStatus/${TaskStatus.Progress.name}'; //enum er value rakci..task_item_card

  static       String updateTaskStatus(String taskId, String status) => '$_baseUrl/updateTaskStatus/$taskId/$status';

}