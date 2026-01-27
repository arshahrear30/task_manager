import 'package:flutter/material.dart';
import 'package:task_manager/ui/widget/body_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

//.....///regex  class
bool isValidEmail(String email) {
  return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
  ).hasMatch(email);
}
//.....



class _SignUpScreenState extends State<SignUpScreen> {

  //controller create by form validation

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      'Join With Us',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),


                    TextFormField(


                      keyboardType: TextInputType.emailAddress,

                      decoration: const InputDecoration(hintText: 'Email'),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required';
                        }
                        if (!isValidEmail(value.trim())) { //regex  class use kore unknown email bad deya jay ..
                          return 'Please enter a valid email';
                        }
                        return null;
                      },



                    ),

                    const SizedBox(height: 16),


                    TextFormField(
                      controller: _firstNameTEController,
                      decoration: const InputDecoration(hintText: 'First name'),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'First name is required';
                        }
                        return null;
                      },

                    ),
                    const SizedBox(height: 16),


                    TextFormField(
                      controller: _lastNameTEController,
                      decoration: const InputDecoration(hintText: 'Last name'),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Last name is required';
                        }
                        return null;
                      },

                    ),
                    const SizedBox(height: 16),


                    TextFormField(
                      controller: _mobileTEController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(hintText: 'Mobile'),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mobile number is required';
                        }
                        return null;
                      },

                    ),
                    const SizedBox(height: 16),


                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: 'Password'),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mobile number is required';
                        }if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },

                    ),



                    const SizedBox(height: 16),



                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {

                          if (_formKey.currentState!.validate()) {

                          }

                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //sob kicu banano and dispose kora o joruri ..

@override
  void dispose() {
  _emailTEController.dispose();
  _firstNameTEController.dispose();
  _lastNameTEController.dispose();
  _mobileTEController.dispose();
  _passwordTEController.dispose();
  super.dispose();
}



}
