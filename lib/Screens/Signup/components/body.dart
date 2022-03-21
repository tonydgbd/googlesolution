import 'package:flutter/material.dart';
import 'package:google_solution/Screens/Login/login_screen.dart';
import 'package:google_solution/Screens/Signup/components/background.dart';
import 'package:google_solution/Screens/Signup/components/or_divider.dart';
import 'package:google_solution/Screens/Signup/components/social_icon.dart';
import 'package:google_solution/components/already_have_an_account_acheck.dart';
import 'package:google_solution/components/rounded_button.dart';
import 'package:google_solution/components/rounded_input_field.dart';
import 'package:google_solution/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_solution/constants/firebase_auth_conts.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController emailControler = TextEditingController();
    TextEditingController passwordControler = TextEditingController();

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              controller: emailControler,
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              controller: passwordControler,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                authController.register(emailControler.value.text, passwordControler.value.text);
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {
                    // authController.signInWithFacebook();
                  },
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {
                    authController.signInWithGoogle();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
