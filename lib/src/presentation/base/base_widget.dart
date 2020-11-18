import 'package:flutter/material.dart';
import 'package:hues_dovui/src/presentation/base/base_viewmodel.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T viewModel, Widget child)
      builder;
  final T viewModel;
  final Widget child;
  final Function(T viewModel) onViewModelReady;

  BaseWidget({this.builder, this.viewModel, this.child, this.onViewModelReady});

  @override
  State<StatefulWidget> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends BaseViewModel> extends State<BaseWidget<T>> {
  @override
  void initState() {
    if (widget.onViewModelReady != null) {
      widget.onViewModelReady(widget.viewModel);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => widget.viewModel..setContext(context),
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
