import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/login_screen.dart';


//Dependency Inversion Principle (DIP) কী?
// High-level class কখনোই Low-level class এর উপর direct depend করবে না।
// দুজনেই interface / abstraction এর উপর depend করবে।
//Viz : Phone = High level Electricity = Low level Charger = Abstraction (interface)
//  ফোন বিদ্যুতের উপর depend করে না,চার্জারের উপর depend করে। এটাই Dependency Inversion।

class NetworkCaller {// Wrapper class: সব network call এক জায়গায় রাখার জন্য

  // POST request পাঠানোর জন্য method
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body,bool isLogin = false}) async {
    try { // এখানে actual POST request পাঠানো হচ্ছে
      log(url);
      log(body.toString());
      final Response response =
      await post(Uri.parse(url), // URL কে URI তে কনভার্ট করা
        body: jsonEncode(body), // Dart Map কে JSON string এ কনভার্ট করা
        headers: {
          'Content-type': 'Application/json', // বলছি সার্ভারকে যে ডাটা JSON
          'token': AuthController.token.toString(), //token pass
        },
      );

      log(response.headers.toString()); //header e token pass korci.
      log(response.statusCode.toString());
      log(response.body.toString());


      if (response.statusCode == 200) { // যদি সার্ভার থেকে 200 আসে মানে success
        return NetworkResponse(
          isSuccess: true, // সফল
          jsonResponse: jsonDecode(response.body), // JSON কে আবার Map এ কনভার্ট
          statusCode: 200,
        );
      }

      else if(response.statusCode == 401){

        if (isLogin==false){

        backToLogin();

        }
        return NetworkResponse(

        isSuccess: false, // ব্যর্থ
        statusCode: response.statusCode,
        jsonResponse: jsonDecode(response.body));

      }

      else { // অন্য কোনো status code এলে (400, 401, 500 ইত্যাদি)
        return NetworkResponse(
            isSuccess: false, // ব্যর্থ
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      }
    }

    catch (e) { // যদি কোনো error হয় (internet off, timeout ইত্যাদি)
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(), // error message পাঠানো
      );
    }
  }
  //atokkon post api niye kaz korci


  //akon get api niya kaz korbo

  //get api er koto body thakey na

  Future<NetworkResponse> getRequest(String url)async {
    try { // এখানে actual POST request পাঠানো হচ্ছে
      log(url);
      final Response response =
      await get(Uri.parse(url), // URL কে URI তে কনভার্ট করা
        headers: {
          'Content-type': 'Application/json', // বলছি সার্ভারকে যে ডাটা JSON
          'token': AuthController.token.toString(), //token pass
        },
      );

      log(response.headers.toString()); //header e token pass korci.
      log(response.statusCode.toString());
      log(response.body.toString());


      if (response.statusCode == 200) { // যদি সার্ভার থেকে 200 আসে মানে success
        return NetworkResponse(
          isSuccess: true, // সফল
          jsonResponse: jsonDecode(response.body), // JSON কে আবার Map এ কনভার্ট
          statusCode: 200,
        );
      }

      else if(response.statusCode == 401){
          backToLogin();

        return NetworkResponse(

            isSuccess: false, // ব্যর্থ
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));

      }

      else { // অন্য কোনো status code এলে (400, 401, 500 ইত্যাদি)
        return NetworkResponse(
            isSuccess: false, // ব্যর্থ
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      }
    }

    catch (e) { // যদি কোনো error হয় (internet off, timeout ইত্যাদি)
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(), // error message পাঠানো
      );
    }
  }
  //get api


  Future<void> backToLogin() async {
    await AuthController.clearAuthData(); //share preperence e token dia jey data save hoicey oita clear korey

    Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigationKey.currentContext!,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
  }
}
