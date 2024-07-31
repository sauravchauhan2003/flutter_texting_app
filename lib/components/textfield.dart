import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final bool Obscure;
  const Mytextfield(
      {super.key,
      required this.hinttext,
      required this.Obscure,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        obscureText: Obscure,
        controller: controller,
        decoration: InputDecoration(
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            hintText: hinttext,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary))),
      ),
    );
  }
}
