import 'package:curso_flutter/app/models/task.dart';
import 'package:curso_flutter/app/repository/task_repository.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier{
 List<Task> _taskList = [];

  final TaskRepository _taskRepository = TaskRepository();

  void fetchTasks() async {
   _taskList = await _taskRepository.getTasks();
   notifyListeners();
  }

  List<Task> get taskList => _taskList;

  onTaskDoneChange(Task task) {
    task.done = !task.done;
    _taskRepository.saveTasks(_taskList);
    notifyListeners();
  }

  void addNewTask(Task task) {
    _taskRepository.addTask(task);
    fetchTasks();
  }

}