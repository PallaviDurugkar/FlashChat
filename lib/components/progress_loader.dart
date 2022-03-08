import 'package:flutter/material.dart';

class ProgressLoader extends StatelessWidget {
  const ProgressLoader({ Key? key, required this.child, required this.loading }) : super(key: key);
  final Widget child;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
       loading? Material(
         color: Colors.white.withOpacity(0.2),
         child: const Center(
            child: CircularProgressIndicator(),
          ),
       ):const SizedBox()
      ],
    );
  }
}