import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/widget/body_background.dart';
import 'package:task_manager/ui/widget/profile_summary_card.dart';
import 'package:task_manager/ui/widget/snack_message.dart';

//HW input validation gula dhik korba signup page er moto .


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  bool _updateProfileInProgress = false;


  @override
  void initState() {
    super.initState();
    _emailTEController.text = AuthController.user?.email ?? '';
    _firstNameTEController.text = AuthController.user?.firstName ?? '';
    _lastNameTEController.text = AuthController.user?.lastName ?? '';
    _mobileTEController.text = AuthController.user?.mobile ?? '';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileSummaryCard(
              enableOnTap: false, //main screen e condition deya acey
            ),


            Expanded(
              child: BodyBackground(
                child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 32,),
                      Text('Update profile', style: Theme.of(context).textTheme.titleLarge,),

                      const SizedBox(height: 8,),



                      photoPickerField(), // Container



                      TextFormField(
                        controller: _emailTEController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                      ),

                      const SizedBox(height: 8,),

                      TextFormField(
                        controller: _firstNameTEController,
                        decoration: const InputDecoration(
                          hintText: 'First name',
                        ),
                      ),

                      const SizedBox(height: 8,),

                      TextFormField(
                        controller: _lastNameTEController,
                        decoration: const InputDecoration(
                          hintText: 'Last name',
                        ),
                      ),


                      const SizedBox(height: 8,),

                      TextFormField(
                        controller: _mobileTEController,
                        decoration: const InputDecoration(
                          hintText: 'Mobile',
                        ),
                      ),

                      const SizedBox(height: 8,),

                      TextFormField(
                        controller: _passwordTEController,
                        decoration: const InputDecoration(
                          hintText: 'Password (optional)',
                        ),
                      ),
                      const SizedBox(height: 16,),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_circle_right_outlined),
                        ),
                      ),


                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


//api call er jonno ekta Future method banabo updateProfile

Future<void> updateProfile() async {

  _updateProfileInProgress = true;

  if (mounted) { //etar maney screen e kaz korley tokon set state hoibo .na hoy hobe na.
    setState(() {});
  }


      Map<String, dynamic> inputData = {
        "firstName": _firstNameTEController.text.trim(),
        "lastName": _lastNameTEController.text.trim(),
        "email": _emailTEController.text.trim(),
        "mobile": _mobileTEController.text.trim(),
      };

      if(_passwordTEController.text.trim().isNotEmpty){
        inputData['password'] = _passwordTEController.text.trim();
      }


      final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.updateProfile, body: inputData,);

      _updateProfileInProgress = false;
      if (mounted) {
        setState(() {});
      }


      if (response.isSuccess) {

        if (mounted) {
          showSnackMessage(context, 'Update profile success!');
        }

      } else {

        if (mounted) {
          showSnackMessage(context, 'Update profile failed. Try again.');
        }

        }
      }
    }
//ei khan e } bracket beshi ascey ata fixed kortey hoibo .eta koi basabo ?





class photoPickerField extends StatelessWidget {
  const photoPickerField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
      ),

      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ) // BorderRadius.only
              ), // BoxDecoration
              alignment: Alignment.center,
              child: const Text('Photo', style: TextStyle(
                  color: Colors.white,
              ),), // TextStyle, Text
            ),), // Container, Expanded

      Expanded(
        flex: 3,
        child: Container(
          padding: EdgeInsets.only(left: 16),
          child: Text('empty '),
            ), // Container
          ), // Expanded
        ],
      ), // Row
    );
  }
}

