import 'package:flutter/material.dart';
import 'package:liveasy_app/components/button.dart';
import 'package:liveasy_app/screens/phone_number_screen.dart';
import 'package:liveasy_app/utility/constants.dart';

class Onboarding_Screen extends StatefulWidget {
  @override
  _Onboarding_ScreenState createState() => _Onboarding_ScreenState();
}

class _Onboarding_ScreenState extends State<Onboarding_Screen> {
  String _selectedLanguage = 'English';

  final List<String> _languages = ['English', 'Spanish', 'French', 'German', 'Hindi'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboarding_background.png',
              fit: BoxFit.fill, // Use BoxFit.cover to ensure the image covers the screen
            ),
          ),
          // Foreground content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Adjusts the column size to its content
                mainAxisAlignment: MainAxisAlignment.center, // Centers elements vertically
                crossAxisAlignment: CrossAxisAlignment.center, // Centers elements horizontally
                children: [
                  Image.asset('assets/images/image-logo.png'),
                  SizedBox(height: 30),
                  const Text(
                    'Please select your Language',
                    style: kHeadingTextStyle,
                  ),
                  SizedBox(height: 10.0),
                  const Text(
                    'You can change the language',
                    style: kSubHeadingTextStyle,
                  ),
                  const Text(
                    'at any time.',
                        style: kSubHeadingTextStyle,
                  ),
                  SizedBox(height: 30.0),
                  // DropdownMenu widget with fixed width
                  DropdownMenu<String>(
                    width: 216, // Fixed width for the dropdown
                    enableSearch: true,
                    enableFilter: true,
                    label: const Text("Select Language"),
                    onSelected: (String? value) {
                      setState(() {
                        _selectedLanguage = value!;
                      });
                    },
                    dropdownMenuEntries: _languages.map<DropdownMenuEntry<String>>((language) {
                      return DropdownMenuEntry<String>(
                        value: language,
                        label: language,
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20.0),
                  Button(
                    title: 'NEXT',
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500), // Duration of the transition
                          pageBuilder: (context, animation, secondaryAnimation) => PhoneNumberScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0); // Start from the right
                            const end = Offset.zero; // End at the current position
                            const curve = Curves.easeInOut; // Use easeInOut curve for smooth transition

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      );

                    },
                    width: 216.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

