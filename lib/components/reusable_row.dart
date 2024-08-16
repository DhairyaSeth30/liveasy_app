import 'package:flutter/material.dart';

class ReusableRow extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final bool isSelected;
  final ValueChanged<int?> onChanged;

  const ReusableRow({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(isSelected ? 0 : 1); // Toggle selection
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Transform.scale(
              scale: 1.5, // Scale the radio button
              child: Radio(
                value: isSelected ? 1 : 0,
                groupValue: 1,
                onChanged: onChanged,
                activeColor: Color.fromRGBO(46, 59, 98, 1),
              ),
            ),
            SizedBox(width: 8.0),
            Image.asset(
              imagePath,
              height: 40.0, // Adjust the image size as needed
              width: 40.0,
            ),
            SizedBox(width: 15.0), // Space between icon and text
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(47, 48, 55, 1),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(106, 108, 123, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}