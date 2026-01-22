import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/ui/widget/body_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : BodyBackground(
        child: SafeArea(//SafeArea এমন একটা widget যা status bar, notch, camera cutout, navigation bar
          // এসবের সাথে overlap হতে দেয় না। UI clash হতে দেয় না।
        child: Padding(
          padding: const EdgeInsets.all(24.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,//start : cross axis-এর শুরু দিক থেকে align করো
            children: [
              const SizedBox(height: 80,),//upor theke 80 poriman jayga carbay
              //Text("Get Started with",style: Theme.of(context).textTheme.titleLarge,),
              //Theme.of : etar modde onek text style paiba
              Text("Get Started with",style:TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),),

              const SizedBox(height: 25,),

              TextFormField(//input field User এখানে লিখতে পারবে
                decoration: InputDecoration(
                  hintText: "Email",
                  fillColor: Colors.black12,
                  filled: true,
                  border: OutlineInputBorder(//Default ভাবে TextField এর নিচে একটা দাগ থাকে (underline) সেটা পুরো তুলে দিচ্ছো
                    borderSide: BorderSide.none, //নিচে একটা দাঘযুক্ত border আসতো । সেটা none করে দিচি চলে গেছেএ ।
                  ),
                  focusedBorder: OutlineInputBorder(//যখন: user field-এ click করে (focus পায়)Normally তখন blue border আসে সেটাও বন্ধ করে দিচ্ছো
                    borderSide: BorderSide.none,
                  ),
                ),
              ),


              const SizedBox(height: 16,), //maj khane 16 poriman jayga thakbay


              TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",
                  fillColor: Colors.black12,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),



            ],
          ),
        ),
        ),
      ),

    );
  }
}