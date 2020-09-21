import 'package:app_test/core/view_models/task_view_model.dart';
import 'package:app_test/helpers/dependency_assembly.dart';
import 'package:flutter_test/flutter_test.dart';


void main(){
  setupDependencyAssemble();

  var taskViewModel = dependencyAssembler<TaskViewModel>();

  taskViewModel.addTask("Task1");
  taskViewModel.addTask("Task2");
  taskViewModel.addTask("Task3");
  taskViewModel.addTask("Task4");
  taskViewModel.addTask("Task5");
  taskViewModel.addTask("Task6");

  group('Task Page Loads', () {

    test('Check list size after add task', () async {
      expect(taskViewModel.todoList.length, 6);
    });

    test('Select and remove task test', () async {
      taskViewModel.selectTask(1,true);
      taskViewModel.selectTask(4,true);
      taskViewModel.removeTask();

      expect(taskViewModel.todoList.length, 4);
    });

    test('Edit task test', () async {
      taskViewModel.editTask(1, "Edit Task1");
      taskViewModel.editTask(2, "Edit Task2");

      expect(taskViewModel.todoList[0].title, "Task1");
      expect(taskViewModel.todoList[1].title, "Edit Task1");
      expect(taskViewModel.todoList[2].title, "Edit Task2");
      expect(taskViewModel.todoList[3].title, "Task6");
    });

    test('Select task test', () async {
      taskViewModel.selectTask(0, true);
      taskViewModel.selectTask(3, true);

      expect(taskViewModel.todoList[0].status, true);
      expect(taskViewModel.todoList[1].status, false);
      expect(taskViewModel.todoList[2].status, false);
      expect(taskViewModel.todoList[3].status, true);
    });

  });




}