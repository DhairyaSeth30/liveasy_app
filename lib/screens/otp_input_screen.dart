import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:liveasy_app/screens/select_profile.dart';
import 'package:liveasy_app/utility/constants.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/button.dart';

class OtpInputScreen extends StatefulWidget {

  final String userPhoneNumber;
  final String verificationId;
  const OtpInputScreen({Key? key, required this.userPhoneNumber, required this.verificationId}) : super(key: key);

  @override
  State<OtpInputScreen> createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OtpInputScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String enteredCode = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  Future<void> _verifyOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      setState(() {
        _isLoading = false;
      });
      _showSnackBar('Phone number verified');
      _navigateToNextScreen();
    } catch (e) {
      _showSnackBar('Failed to verify OTP: $e');
    }
  }

  Future<void> _verifyPhoneNumber() async {
    setState(() {
      _isLoading = true;
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: widget.userPhoneNumber,
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
          _isLoading = false;
        });
        _showSnackBar('OTP resent to your phone');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          verificationId = widget.verificationId;
        });
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _navigateToNextScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SelectProfile_Screen()), // Navigate to the next screen
    );
  }

  // void _listenForCode() {
  //   SmsAutoFill().listenForCode();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  // Centers elements vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Centers elements horizontally
            children: [
              const Text(
                'Verify Phone',
                style: kHeadingTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: kSubHeadingTextStyle,
                  children: [
                    TextSpan(
                      text: 'Code is sent to ',
                    ),
                    TextSpan(
                      text: widget.userPhoneNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.0),

              OtpTextField(
                numberOfFields: 6,
                showFieldAsBox: true,
                fieldWidth: 40.h,
                fieldHeight: 40.h,
                filled: true,
                fillColor: Color.fromRGBO(147, 210, 243, 1),
                onCodeChanged: (String code) {
                  // enteredCode = code;
                },
                onSubmit: (String verificationCode){
                  enteredCode = verificationCode;
                },
              ),
              const SizedBox(height: 20.0),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: kSubHeadingTextStyle,
                  children: [
                    const TextSpan(
                      text: 'Didn’t receive the code? ',
                    ),
                    TextSpan(
                      text: 'Request Again',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _verifyPhoneNumber();
                        },
                    ),
                  ],
                ),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       'Didn’t receive the code?',
              //       style: kSubHeadingTextStyle,
              //     ),
              //     TextButton(
              //       onPressed: () {
              //         _verifyPhoneNumber();
              //       },
              //       child: Text(
              //           'Request Again',
              //           style: TextStyle(
              //             fontFamily: 'Roboto',
              //             fontSize: 14.0,
              //             fontWeight: FontWeight.bold,
              //             color: Color.fromRGBO(106, 108, 123, 1),
              //           ),
              //       ),
              //     ),
              //   ],
              // ),

              SizedBox(height: 20.0),
              Button(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  _verifyOTP(enteredCode);
                },
                title: 'VERIFY AND CONTINUE',
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



