import 'package:app_test/UI/widgets/custom_drawer.dart';
import 'package:app_test/core/enums/test_enum.dart';
import 'package:app_test/core/view_models/task_view_model.dart';
import 'package:app_test/helpers/color_utils.dart';
import 'package:app_test/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'base_view.dart';

class TaskListView extends StatefulWidget {
  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  final _formKey = GlobalKey<FormState>();

  final _toDoController = TextEditingController();
  Form _inputTextFormField;
  TextStyle _titleTextStyle;
  TextStyle _subTitleTextStyle;

  @override
  Widget build(BuildContext context) {


    _inputTextFormField = Form(
      key: _formKey,
      child: Expanded(
        child: TextFormField(
          controller: _toDoController,
          textAlign: TextAlign.center,
          style: TextStyle(color: ColorUtils.primaryColor),
          validator: (value) {
              if (value.isEmpty) {
                return Constants.input_name_task_error_message;
              } else {
                return null;
              }
          },
          decoration: InputDecoration(
            errorStyle: TextStyle(color: ColorUtils.primaryColor),
            //errorBorder: BorderSide(color: ColorUtils.secondaryColor),
            labelStyle: TextStyle(color: ColorUtils.secondaryColor),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorUtils.secondaryColor)
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorUtils.secondaryColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorUtils.secondaryColor),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorUtils.secondaryColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorUtils.secondaryColor),
            ),
          ),
        ),
      ),
    );

    _titleTextStyle = TextStyle(
        color: ColorUtils.primaryColor,
        fontSize: 17.0
    );

    _subTitleTextStyle = TextStyle(
        color: ColorUtils.primaryColor,
        fontSize: 13.0
    );

    return BaseView<TaskViewModel>(
      builder: (context, viewModel, child) => Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
              title: Text(Constants.app_bar_message),
              actions: [
                PopupMenuButton<Test>(
                  onSelected: (Test result) {},
                  itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<Test>>[
                    const PopupMenuItem<Test>(
                      value: Test.test1,
                      child: Text(Constants.first_popup_menu_item_message),
                    ),
                    const PopupMenuItem<Test>(
                      value: Test.test2,
                      child: Text(Constants.second_popup_menu_item_message),
                    ),
                    const PopupMenuItem<Test>(
                      value: Test.test3,
                      child: Text(Constants.third_popup_menu_item_message),
                    )
                  ],
                )
              ]
          ),
          floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                    child: Icon(
                        Icons.delete,
                        color: Colors.white
                    ),
                    onPressed: (){
                      viewModel.removeTask();
                    }
                ),
                SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                    child: Icon(
                        Icons.add_circle_outline,
                        color: Colors.white
                    ),
                    onPressed: () {
                      _showAddTaskDialog(context, viewModel);
                    }
                )
              ]
          ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(viewModel.title,
                style: TextStyle(
                    color: ColorUtils.primaryColor,
                    fontSize: 20.0
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(top:5.0),
                  itemCount: viewModel.todoList.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onLongPress: (){
                      _showEditTaskDialog(context, viewModel, index);
                    },
                    child: CheckboxListTile(
                      title: Text(
                        (index + 1).toString() + " - " +
                            viewModel.todoList[index].title,
                        style: TextStyle(
                            color: ColorUtils.primaryColor),
                      ),
                      value: viewModel.todoList[index].status,
                      onChanged: (check){
                        viewModel.selectTask(index, check);
                      },
                    ),
                  )
              ),
            ),
          ],
        )
      ),
    );
  }

  _showAddTaskDialog(context, viewModel) async {
    Widget cancelButton = FlatButton(
        child: Text(Constants.cancel_message,
            style: TextStyle(
                color: ColorUtils.secondaryColor
            )
        ),
        onPressed: (){
          _toDoController.text = "";
          Navigator.of(context).pop();
        }
    );

    Widget confirmButton = FlatButton(
        child: Text(Constants.save_message,
          style: TextStyle(
              color: ColorUtils.secondaryColor
          ),
        ),
        onPressed: () {

          if (_formKey.currentState.validate()) {
            viewModel.addTask(_toDoController.text);
            _toDoController.text = "";
            Navigator.of(context).pop();
          }

        }
    );

    //settings AlertDialog
    AlertDialog alert = AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Constants.add_task_message,
            style: _titleTextStyle,
          ),
          Text(Constants.insert_name_add_task_message,
            style: _subTitleTextStyle,
          ),
        ],
      ),
      content: _inputTextFormField,
      actions: [
        cancelButton,
        confirmButton
      ],
    );

    //show dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }

  _showEditTaskDialog(context, viewModel, index) async {

    String textFieldMessage = viewModel.todoList[index].title;
    _toDoController.text = textFieldMessage;

    Widget confirmButton = FlatButton(
        child: Text(Constants.save_message,
            style: TextStyle(
                color: ColorUtils.secondaryColor
            )
        ),
        onPressed: (){
          if(_formKey.currentState.validate()){
            viewModel.editTask(index, _toDoController.text);
            _toDoController.text = "";
            Navigator.of(context).pop();
          }
        }
    );

    //settings AlertDialog
    AlertDialog alert = AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Constants.edit_task_message,
            style: _titleTextStyle,
          ),
          Text(Constants.edit_name_task_message,
            style: _subTitleTextStyle,
          ),
        ],
      ),
      content: _inputTextFormField,
      actions: [
        confirmButton
      ],
    );

    //show dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }
}
