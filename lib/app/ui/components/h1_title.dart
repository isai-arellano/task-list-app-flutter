import 'package:flutter/material.dart';

class H1Title extends StatelessWidget {
  const H1Title(
    this.text, {
      Key? key,
      this.color,
    }) : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(text,
             style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 18, 
              fontWeight: FontWeight.w600,
              color: color,
    ));
  }
}