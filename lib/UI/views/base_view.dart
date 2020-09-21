import 'package:app_test/core/view_models/base_view_model.dart';
import 'package:app_test/helpers/dependency_assembly.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T viewModel, Widget child) builder;

  BaseView({this.builder});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T model = dependencyAssembler<T>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
