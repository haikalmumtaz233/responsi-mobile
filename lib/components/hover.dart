import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class Hover extends StatelessWidget {
  Widget child;
  void Function()? onTap;
  Hover({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: onTap,
      child: child,
    );
  }
}
