import 'package:flutter/material.dart';
import 'package:liveasy_app/utility/constants.dart';

import '../components/button.dart';
import '../components/reusable_row.dart';

class SelectProfile_Screen extends StatefulWidget {
  const SelectProfile_Screen({super.key});

  @override
  State<SelectProfile_Screen> createState() => _SelectProfile_ScreenState();
}

class _SelectProfile_ScreenState extends State<SelectProfile_Screen> {
  int _selectedRadio = 0;

  void _handleRowClick(int index, String title) {
    setState(() {
      _selectedRadio = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers elements vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Centers elements horizontally
            children: [
              Text(
                  'Please select your profile',
                style: kHeadingTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32,),
              ReusableRow(
                imagePath: 'assets/images/export-logo.png',
                title: 'Shipper',
                subtitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing',
                isSelected: _selectedRadio == 1,
                onChanged: (value) {
                  _handleRowClick(1, 'Shipper');
                },
              ),
              SizedBox(height: 32,),
              ReusableRow(
                imagePath: 'assets/images/transport-logo.png',
                title: 'Transporter',
                subtitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing',
                isSelected: _selectedRadio == 2,
                onChanged: (value) {
                  _handleRowClick(2, 'Transporter');
                },
              ),
              SizedBox(height: 20.0),
              Button(
                onPressed: () {

                },
                title: 'CONTINUE',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
