import 'package:chatapp/auth/authentication.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/textfield.dart';
import 'package:flutter/material.dart';

class Login_page extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  void login() async {
    final authservice = Authservices();
    try {
      authservice.signInWithEmailPassword(
          _emailcontroller.text, _passwordcontroller.text);
    } catch (e) {
      print(e);
    }
  }

  final void Function()? ontap;

  Login_page({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Logo
            Icon(
              Icons.message,
              color: Theme.of(context).colorScheme.primary,
              size: 60,
            ),
            SizedBox(
              height: 25,
            ),
            //email
            Mytextfield(
              hinttext: "Enter email here",
              Obscure: false,
              controller: _emailcontroller,
            ),
            SizedBox(
              height: 10,
            ),

            //password
            Mytextfield(
              hinttext: "Enter password here",
              Obscure: true,
              controller: _passwordcontroller,
            ),
            SizedBox(
              height: 30,
            ),

            //login
            MyButton(text: 'Log In', onTap: login),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member?"),
                GestureDetector(
                  onTap: ontap,
                  child: Text(
                    'Register',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )

            //register
          ],
        ),
      ),
    );
  }
}
