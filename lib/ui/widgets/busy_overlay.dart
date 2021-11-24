import 'package:flutter/material.dart';

/// A modal overlay that will show over your child widget (fullscreen) when the show value is true
///
/// Wrap your scaffold in this widget and set show value to model.isBusy to show a loading modal when
/// your model state is Busy
class BusyOverlay extends StatelessWidget {
  final Widget child;
  final String title;
  final bool show;

  const BusyOverlay({
    Key? key,
    required this.child,
    this.title = 'Please wait...',
    this.show = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Material(
      child: Stack(
        children: <Widget>[
          child,
          IgnorePointer(
            child: Opacity(
              opacity: show ? 1.0 : 0.0,
              child: Container(
                width: screenSize.width,
                height: screenSize.height,
                alignment: Alignment.center,
                color: const Color.fromARGB(100, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const CircularProgressIndicator(),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
