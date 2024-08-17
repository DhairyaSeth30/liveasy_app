
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:liveasy_app/utility/constants.dart';
import '../components/button.dart';
import 'otp_input_screen.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});


  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String userPhoneNumber = '';
  String isoCode = 'IN';
  String countryCode = '+91';
  String _verificationId = "";
  bool _isLoading = false;


  Future<void> _verifyPhoneNumber() async {
    setState(() {
      _isLoading = true;
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: userPhoneNumber,
      //1 Verify phone number
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval or instant verification
        await _auth.signInWithCredential(credential);
        setState(() {
          _isLoading = false;
        });
        _showSnackBar('Phone number automatically verified');
        // _navigateToNextScreen();
      },
      //2 verification failed
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _isLoading = false;
        });
        _showSnackBar('Verification failed: ${e.message}');
      },
      //3 code sent
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _isLoading = false;
        });
        _showSnackBar('OTP sent to your phone');
        _navigateToNextScreen(_verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _navigateToNextScreen(String? verificationId) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OtpInputScreen(userPhoneNumber : userPhoneNumber, verificationId : _verificationId)), // Navigate to the next screen
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/phone_number_background.png',
              fit: BoxFit.cover, // Use BoxFit.cover to ensure the image covers the screen
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,  // Centers elements vertically
                  crossAxisAlignment: CrossAxisAlignment.center, // Centers elements horizontally
                  children: [
                    const Text(
                      'Please enter your mobile number',
                      style: kHeadingTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 7.h),
                    const Text(
                      'You’ll receive a 6 digit code',
                      style: kSubHeadingTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'to verify next.',
                      style: kSubHeadingTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15.h),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:const Color.fromRGBO(15, 13, 35, 1),
                          width: 1.0,
                        ), // Customize border properties as needed
                        borderRadius: BorderRadius.circular(
                            4), // Adjust border radius as needed
                        color: const Color.fromRGBO(245, 245, 245, 1),
                      ),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (value) {
                          userPhoneNumber = value.phoneNumber!;
                        },
                        initialValue:
                        PhoneNumber(isoCode: isoCode, dialCode: countryCode),
                        keyboardType: TextInputType.phone,
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                        ),
                        cursorColor: const Color.fromRGBO(15, 13, 35, 1),
                        inputBorder: const OutlineInputBorder(),
                        inputDecoration: InputDecoration(
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.h,
                            color: const Color.fromRGBO(106, 108, 123, 1),
                          ),
                          border: InputBorder
                              .none, // Set input border to none to avoid duplication
                        ),
                      ),
                    ),

                    SizedBox(height: 15.h),
                    Button(
                      title: 'CONTINUE',
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => OtpInputScreen(userPhoneNumber: userPhoneNumber, verificationId: _verificationId)));
                        _verifyPhoneNumber();
                      },
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : null,
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







