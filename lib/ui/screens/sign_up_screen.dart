import 'package:flutter/material.dart';
import 'package:task_manager/data.network_caller/network_caller.dart';
import 'package:task_manager/data.network_caller/network_response.dart';
import 'package:task_manager/data.network_caller/utility/urls.dart';
import 'package:task_manager/ui/widget/body_background.dart';
import 'package:task_manager/ui/widget/snack_message.dart';

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
  bool _signUpInProgress = false; // in progress er jonno use korci load hoibo icon ..






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
                      controller: _emailTEController,


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
                          return 'Password is required at least 8 digit';
                        }if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },

                    ),



                    const SizedBox(height: 16),



                    SizedBox(
                      width: double.infinity,

                      child: Visibility( //eta deyar karon e loading ta visibl hoibo .


                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        visible: _signUpInProgress==false, //



                        child: ElevatedButton(
                          onPressed: () {
                            _signUp();
                          } ,
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
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

  Future<void> _signUp() async{
    //await শুধু async function এর ভেতরে কাজ করে। যেখানে Future আছে → সেখানে async লাগে।
    //async : UI ব্লক হবে না ..২ সেকেন্ড পরে result আসবে.. meanwhile ইউজার স্ক্রল/টাইপ করতে পারবে

    if (_formKey.currentState!.validate()) {

      _signUpInProgress = true;
      if(mounted){
        setState(() {
        });
      }


      final NetworkResponse response = await NetworkCaller().postRequest(Urls.registration, body : {

        "email":_emailTEController.text.trim(),
        "firstName":_firstNameTEController.text.trim(),
        "lastName":_lastNameTEController.text.trim(),
        "mobile":_mobileTEController.text.trim(),
        "password":_passwordTEController.text,


      });
      _signUpInProgress = false ; //network call to ses abar ar gurar dorkar nai .. tai false
      if(mounted){
        setState(() {
        });
      }

      if(response.isSuccess){
        _clearTextFields(); //ek bar succes hoiley purber input gula mucay jabe




        if(mounted){//mounted : user ki ei screen e acay ? thakle ki hoibo ? seitar kaz i hoilo mountain
          showSnackMessage(context, 'Account has been created successfully');
        }else{


          if(mounted) { //mounted : user ki ei screen e acay ? thakle ki hoibo ? seitar kaz i hoilo mountain

            showSnackMessage(
                context, 'Account has been created failed',
                true);
          }

        }

      }
    }
  }


  void _clearTextFields() {// 1 bar signup done hoiley purber input gula mucay jabe
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();


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
