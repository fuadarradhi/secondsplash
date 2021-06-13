import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/splashcreen.dart';

/// Controller used for control splash close,
/// use `controller.close()` to close splash
/// when application is ready to show.
class SplashController {
  _SecondSplashState? _splash;

  void addState(_SecondSplashState splash) {
    this._splash = splash;
  }

  void close() {
    _splash?.close();
  }
}

/// Wrap widget with `SecondSplash` for use splashscreen,
/// use with `MaterialApp` or `CupertinoApp`
class SecondSplash extends StatefulWidget {
  final Widget? child;
  final Widget? next;
  final Decoration? decoration;
  final SplashController? controller;
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  const SecondSplash({
    Key? key,
    @required this.next,
    this.child,
    this.decoration,
    this.controller,
    this.systemUiOverlayStyle,
  }) : super(key: key);

  @override
  _SecondSplashState createState() => _SecondSplashState();
}

class _SecondSplashState extends State<SecondSplash>
    with TickerProviderStateMixin {
  late AnimationController controllerFinished;
  late Animation<double> animationFinished;

  bool showSplash = true;

  @override
  void initState() {
    super.initState();

    controllerFinished = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 700,
      ),
    );

    animationFinished = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(
      controllerFinished,
    );

    widget.controller!.addState(this);
  }

  @override
  void dispose() {
    controllerFinished.dispose();
    super.dispose();
  }

  void close() {
    if (mounted) {
      controllerFinished.forward().then((_) {
        if (mounted) {
          setState(() {
            showSplash = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // change systemUiOverlay
    // statusbar, brightness etc
    SystemChrome.setSystemUIOverlayStyle(
      widget.systemUiOverlayStyle != null
          ? widget.systemUiOverlayStyle!
          : SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
    );

    // we need this to make sure status bar brighness is working
    return Stack(
      children: [
        widget.next ?? Container(),

        // use scaffold with transparent background
        if (showSplash)
          FadeTransition(
            opacity: animationFinished,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                brightness: widget.systemUiOverlayStyle != null
                    ? widget.systemUiOverlayStyle!.statusBarBrightness != null
                        ? (widget.systemUiOverlayStyle!.statusBarBrightness ==
                                Brightness.dark
                            ? Brightness.light
                            : Brightness.dark)
                        : Brightness.dark
                    : Brightness.dark,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),

              // this is splash container
              body: Container(
                // constant
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,

                // user spesified with default value
                decoration: widget.decoration != null
                    ? widget.decoration
                    : BoxDecoration(
                        color: Colors.blue,
                      ),
                child: widget.child ?? DefaultSplashScreen(),
              ),
            ),
          ),
      ],
    );
  }
}
