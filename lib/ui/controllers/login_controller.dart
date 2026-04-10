//login er logic gula just ei khan e rakpo ..api call aro extra jinish gula
//logic gulakey stack holder voley ..eikhan only business logic er kaz korbo.
import 'package:get/get.dart';


class LoginController extends GetxController{

  Future<void> login() async {


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

}