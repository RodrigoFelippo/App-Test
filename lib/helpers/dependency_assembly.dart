
import 'package:app_test/core/view_models/task_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt dependencyAssembler = GetIt.instance;

void setupDependencyAssemble(){
  dependencyAssembler.registerFactory(() => TaskViewModel());
}