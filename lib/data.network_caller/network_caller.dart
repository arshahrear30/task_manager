import 'dart:convert';
import 'package:http/http.dart';
import 'package:task_manager/data.network_caller/network_response.dart';


//Dependency Inversion Principle (DIP) কী?
// High-level class কখনোই Low-level class এর উপর direct depend করবে না।
// দুজনেই interface / abstraction এর উপর depend করবে।
//Viz : Phone = High level Electricity = Low level Charger = Abstraction (interface)
//  ফোন বিদ্যুতের উপর depend করে না,চার্জারের উপর depend করে। এটাই Dependency Inversion।

class NetworkCaller {// Wrapper class: সব network call এক জায়গায় রাখার জন্য

  // POST request পাঠানোর জন্য method
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body}) async {



    try { // এখানে actual POST request পাঠানো হচ্ছে
      final Response response =
      await post(
        Uri.parse(url),               // URL কে URI তে কনভার্ট করা
        body: jsonEncode(body),       // Dart Map কে JSON string এ কনভার্ট করা
        headers: {
          'Content-type': 'Application/json', // বলছি সার্ভারকে যে ডাটা JSON
        },
      );




      if (response.statusCode == 200) { // যদি সার্ভার থেকে 200 আসে মানে success
        return NetworkResponse(
          isSuccess: true,                         // সফল
          jsonResponse: jsonDecode(response.body), // JSON কে আবার Map এ কনভার্ট
          statusCode: 200,
        );
      }


      else { // অন্য কোনো status code এলে (400, 401, 500 ইত্যাদি)
        return NetworkResponse(
            isSuccess: false,                      // ব্যর্থ
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      }




    }

    catch (e) { // যদি কোনো error হয় (internet off, timeout ইত্যাদি)
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),   // error message পাঠানো
      );
    }
  }
}
