import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/forgot_password_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/widget/body_background.dart';
import 'package:task_manager/ui/widget/snack_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loginInProgress = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : BodyBackground(
        child: SafeArea(//SafeArea এমন একটা widget যা status bar, notch, camera cutout, navigation bar
          // এসবের সাথে overlap হতে দেয় না। UI clash হতে দেয় না।
        child: Padding(
          padding: const EdgeInsets.all(24.0),




            child: SingleChildScrollView( //ete deyar karon e keyboard asley jei akta screen e broken image asto seitacoila jaibo ..

              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,//start : cross axis-এর শুরু দিক থেকে align করো
                
                
                  children: [
                    const SizedBox(height: 80,),//upor theke 80 poriman jayga carbay
                    //Text("Get Started with",style: Theme.of(context).textTheme.titleLarge,),
                    //Theme.of : etar modde onek text style paiba
                    Text("Get Started with",
                      style:Theme.of(context).textTheme.titleLarge,//default text style from app.dart
                    ),
                
                    const SizedBox(height: 25,),
                
                    TextFormField(//input field User এখানে লিখতে পারবে
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress, //eta dilay amar keybord e default screen e @ ta show korbey.
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),

                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter valid email';
                        }
                        return null;
                      },

                    ),
                
                
                
                    //border: OutlineInputBorder(//Default ভাবে TextField এর নিচে একটা দাগ থাকে (underline) সেটা পুরো তুলে দিচ্ছো
                    //   borderSide: BorderSide.none, //নিচে একটা দাঘযুক্ত border আসতো । সেটা none করে দিচি চলে গেছেএ ।
                    //   ),
                    //  focusedBorder: OutlineInputBorder(//যখন: user field-এ click করে (focus পায়)Normally তখন blue border আসে সেটাও বন্ধ করে দিচ্ছো
                    //  borderSide: BorderSide.none,
                    //  ),
                
                
                
                
                    const SizedBox(height: 16,), //maj khane 16 poriman jayga thakbay
                
                
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true, //password ta hide raktey use hoy .. dot dot dekaibo .
                      decoration: InputDecoration(
                        hintText: "Password",
                
                      ),

                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter valid password';
                        }
                        return null;
                      },

                    ),
                
                
                    const SizedBox(height: 25,),
                
                    SizedBox(
                
                      width: double.infinity,
                
                      child: Visibility(
                        visible: _loginInProgress==false,

                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),

                        child: ElevatedButton(
                        onPressed: login,
                        child: const Icon(Icons.arrow_circle_right_outlined),
                                            ),
                      ),
                    ),
                
                
                
                    const SizedBox(height: 48,),
                
                
                    Center(
                        child: TextButton(
                          onPressed: (){
                
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordScreen(),
                                ),
                            );
                
                                },
                          child: const Text("Forgot Password?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                    ),
                
                
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                
                      children: [
                
                        const Text("Don't have an account?", style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54
                        ),
                        ),
                
                        TextButton(
                          onPressed: () {
                
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                            );
                
                
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen() ),); //ek screen theke onno screen e jawar upay.
                
                          },
                          child: const Text(
                            'Sign Up',
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

  Future<void> login() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _loginInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller().postRequest(Urls.login, body:{
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,
    },
    isLogin: true);
    _loginInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {

      await AuthController.saveUserInformation(
      response.jsonResponse!['token'], UserModel.fromJson(response.jsonResponse!['data']));
      //data gula doira auth controller er saveUserInformation e pataibey



      if (mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MainBottomNavScreen()));
      }
    } else {
      if (response.statusCode == 401) {
        if (mounted) {
          showSnackMessage(context, 'Please check email/password');
        }
      } else {
        if (mounted) {
          showSnackMessage(context, 'Login failed. Try again');
        }
      }
    }

  }




  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }


}
