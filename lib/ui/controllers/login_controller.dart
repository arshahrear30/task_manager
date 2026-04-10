//login er logic gula just ei khan e rakpo ..api call aro extra jinish gula
//logic gulakey stack holder voley ..eikhan only business logic er kaz korbo.
import 'package:get/get.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';


class LoginController extends GetxController{

  bool _loginInProgress = false;

  String _failedMessage = ' ';

  bool get loginInProgress => _loginInProgress;
  String get failureMessage => _failedMessage;


  Future<bool> login(String email, String password) async {

//formKey validation ata UI er kaz ,,ekon amra logic er part niya kaz korchi.
    _loginInProgress = true;
   //mounted eta proyojon nai karon getX e Update diya hoye jay.

    update();

    NetworkResponse response = await NetworkCaller().postRequest(Urls.login, body:{
      "email": email,
      "password": password,
    },
        isLogin: true);
    _loginInProgress = false;
    update();
    if (response.isSuccess) {
      await AuthController.saveUserInformation(
          response.jsonResponse!['token'],
          UserModel.fromJson(response.jsonResponse!['data']));
      //data gula doira auth controller er saveUserInformation e pataibey


      return true;
      }else {
      if (response.statusCode == 401) {

        _failedMessage = 'Please check email/password';

      } else {

        _failedMessage = 'Login failed. Try again';

      }
    }

    return false;

  }

}