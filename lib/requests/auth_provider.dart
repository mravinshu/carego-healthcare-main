import 'dart:convert';

import 'package:carego_healthcare/requests/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  Future<Map<String, dynamic>> register(
      String fullName, String phoneNumber, String email, String pass) async {
    try {
      Map<String, String> body = {
        "full_name": fullName,
        "phone_number":
            phoneNumber, // add +91 in the prefix and then a space and then the 10 digit number
        "email": email,
        "password": pass
      };
      var response = await http.post(
        Uri.parse(
          'https://carego-healthcare.herokuapp.com/register',
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );
      var extractedData = json.decode(response.body) as Map<String, dynamic>;
      return extractedData;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> login(String phoneNumber, String pass) async {
    try {
      Map<String, String> body = {
        'phone_number':
            phoneNumber, // add +91 in the prefix and then a space and then the 10 digit number
        'password': pass,
      };
      print("BODY ${phoneNumber}");
      var response = await http.post(
        Uri.parse(
          'https://carego-healthcare.herokuapp.com/login',
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );
      var extractedData = json.decode(response.body) as Map<String, dynamic>;
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> otpVerification(String userOtp) async {
    try {
      Map<String, String> body = {"otp": userOtp};
      var response = await http.post(
        Uri.parse(
          'https://carego-healthcare.herokuapp.com/otp',
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );
      var extractedData = json.decode(response.body) as Map<String, dynamic>;
      return extractedData;
    } catch (e) {
      // print(e);
      rethrow;
    }
  }

  Future<http.Response> profile(id) async {
    Uri url1 = Uri.parse(BASE_URL + PROFILE + "/" + id);
    print(url1);
    final http.Response response = await http.post(
      url1,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    // print("BODY ${response.body}");
    // print("STATUS CODE ${response.statusCode}");
    return response;
  }

  Future<http.Response> getCategory() async {
    Uri url1 = Uri.parse(BASE_URL + CATEGORY);
    // print(url1);
    final http.Response response = await http.get(
      url1,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    // print("BODY ${response.body}");
    // print("STATUS CODE ${response.statusCode}");
    return response;
  }

  Future<http.Response> getService(id) async {
    Uri url1 = Uri.parse(BASE_URL + SERVICES + "/" + id);
    // print(url1);
    final http.Response response = await http.get(
      url1,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    // print("BODY ${response.body}");
    // print("STATUS CODE ${response.statusCode}");
    return response;
  }

  Future<http.Response> paymentSuccess(id, status) async {
    Uri url1 = Uri.parse(BASE_URL + PAYMENT_SUCCESS + "/" + id.toString());
    print(url1);
    final http.Response response = await http.post(
      url1,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"success": status}),
    );
    // print("BODY ${response.body}");
    // print("STATUS CODE ${response.statusCode}");
    return response;
  }

  Future<http.Response> bookingService(userId, serviceId, body) async {
    Uri url1 = Uri.parse(BASE_URL +
        "/user/" +
        userId.toString() +
        "/service/" +
        serviceId.toString() +
        BOOKING_SERVICE);
    print(url1);
    print(body);
    final http.Response response = await http.post(
      url1,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    // print("BODY ${response.body}");
    // print("STATUS CODE ${response.statusCode}");
    return response;
  }

  Future<http.Response> editUser(userId, body) async {
    Uri url1 = Uri.parse(BASE_URL + EDIT_USER + "/" + userId.toString());
    print(url1);
    final http.Response response = await http.post(
      url1,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    // print("BODY ${response.body}");
    // print("STATUS CODE ${response.statusCode}");
    return response;
  }
}
