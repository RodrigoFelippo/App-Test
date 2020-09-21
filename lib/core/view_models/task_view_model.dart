import 'dart:convert';
import 'package:app_test/core/models/task_model.dart';
import 'package:app_test/helpers/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base_view_model.dart';

class TaskViewModel extends BaseViewModel{
  static const String LIST_KEY = "LIST_KEY";
  String title = Constants.todo_list_title_message;
  List<TaskModel> todoList = [];
  SharedPreferences prefs;

  TaskViewModel(){
      loadList();
  }

  Future<void> loadList() async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(LIST_KEY)){
      String todoListPref = prefs.getString(LIST_KEY);
      todoList = decodeTasks(todoListPref);
      notifyListeners();
    }
  }

  void addTask(String task){
    todoList.add(TaskModel(task, false));
    prefs.setString(LIST_KEY, encodeTasks(todoList));
    notifyListeners();
  }

  void editTask(int index, String task){
    bool status = this.todoList[index].getStatus();
    this.todoList.removeAt(index);
    this.todoList.insert(index, TaskModel(task, status));
    prefs.setString(LIST_KEY, encodeTasks(todoList));
    notifyListeners();
  }

  void removeTask(){
    this.todoList.removeWhere((task) => task.status);
    prefs.setString(LIST_KEY, encodeTasks(todoList));
    notifyListeners();
  }

  void selectTask(int index, bool status){
    this.todoList[index].setStatus(status);
    prefs.setString(LIST_KEY, encodeTasks(todoList));
    notifyListeners();
  }

  static String encodeTasks(List<TaskModel> tasks) => json.encode(
    tasks.map<Map<String, dynamic>>((music) => TaskModel.toMap(music))
        .toList(),
  );

  static List<TaskModel> decodeTasks(String tasks) =>
      (json.decode(tasks) as List<dynamic>)
          .map<TaskModel>((item) => TaskModel.fromJson(item))
          .toList();

}