class Urls {

  static final String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static final String registration = '&_baseUrl/registration';
  static final String login = '&_baseUrl/login';
  static const String createNewTask = '&_baseUrl/createTask';
  static const String getTaskStatusCount = '&_baseUrl/TaskStatusCount';
  static const String getNewTasks = '&_baseUrl/listTaskByStatus/New';
  static       String updateTaskStatus(String taskId, String status) => '$_baseUrl/updateTaskStatus/$taskId/$status';

}