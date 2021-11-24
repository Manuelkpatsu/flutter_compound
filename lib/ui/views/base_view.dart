import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T) onModelReady;
  final T model;
  final Widget child;

  const BaseView({
    Key? key,
    required this.builder,
    required this.onModelReady,
    required this.model,
    required this.child,
  }) : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
  late T _model;

  @override
  void initState() {
    _model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady(_model);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => _model,
      child: Consumer<T>(
        child: widget.child,
        builder: widget.builder,
      ),
    );
  }
}
