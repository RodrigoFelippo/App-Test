import 'dart:convert';

class TaskModel {
  String title;
  bool status;

  TaskModel(this.title, this.status);

  factory TaskModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskModel(
        jsonData['title'],
        jsonData['status']
    );
  }

  static Map<String, dynamic> toMap(TaskModel taskModel) => {
    'title': taskModel.title,
    'status': taskModel.status,
  };

  getTitle(){
    return title;
  }

  setTitle(String title){
    this.title = title;
  }

  getStatus(){
    return status;
  }

  setStatus(bool status){
    this.status = status;
  }
}