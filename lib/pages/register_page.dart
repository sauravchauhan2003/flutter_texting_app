import 'package:chatapp/auth/authentication.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/textfield.dart';
import 'package:flutter/material.dart';

class Register_page extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _cnfpasswordcontroller = TextEditingController();
  void register() {
    final authservice = Authservices();
    if (_passwordcontroller.text == _emailcontroller.text) {
      try {
        authservice.signUpwithEmailpassword(
            _emailcontroller.text, _cnfpasswordcontroller.text);
      } catch (e) {
        print(e);
      }
    }
  }

  final void Function()? ontap;

  Register_page({super.key, required this.ontap});

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
              height: 10,
            ),
            Mytextfield(
              hinttext: "Confirm Password",
              Obscure: true,
              controller: _cnfpasswordcontroller,
            ),
            SizedBox(
              height: 30,
            ),

            //login
            MyButton(text: 'Register', onTap: register),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                GestureDetector(
                  onTap: ontap,
                  child: Text(
                    'Log In',
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
