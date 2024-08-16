import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key,
    required this.title,
    required this.onPressed,
    this.border,
    this.width,
    this.child,
  });

  final String title;
  final Function onPressed;
  final Color? border;
  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            width: width ?? double.infinity,
            child: Material(
              color: const Color.fromRGBO(46, 59, 98, 1),
              child: MaterialButton(
                onPressed: () {
                  onPressed();
                },
                minWidth: 200.0,
                height: 56.0,
                child: child ??
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

