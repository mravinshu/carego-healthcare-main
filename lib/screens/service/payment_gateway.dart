import 'package:carego_healthcare/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../requests/auth_provider.dart';
import '../../requests/endpoints.dart';
import '../../widgets/popup_response.dart';

class PaymentGateway extends StatefulWidget {
  const PaymentGateway(
      {Key? key,
      required this.fina_price,
      required this.service_id,
      required this.service_name})
      : super(key: key);

  final int fina_price;
  final int service_id;
  final String service_name;

  @override
  State<PaymentGateway> createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  var _razorpay = Razorpay();

  String userName = "";
  String userEmail = "";
  String userPhone = "";

  void getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    int userId = 0;
    String name = "";
    String email = "";
    String phone = "";
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        userName = prefs.getString("user_name")!;
        userEmail = prefs.getString("user_email")!;
        userPhone = prefs.getString("user_phone")!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    double width = mediaQuery.size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          elevation: 10,
          child: Container(
            width: width / 1.2,
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/SVG/Card.svg',
                  width: width / 1.2,
                ),
                Positioned(
                    child: SizedBox(
                      width: width / 2.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: width / 2.1,
                            child: Text(
                              widget.service_name,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                    top: height / 20,
                    right: width / 10),
                Positioned(
                    child: Text("₹${widget.fina_price.toString()}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    bottom: height / 10,
                    left: width / 10),
                Positioned(
                    child: GestureDetector(
                      onTap: () {
                        openCheckout();
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Proceed",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                    top: height / 6,
                    right: width / 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': API_RAZORPAY_KEY,
      'amount': widget.fina_price * 100,
      'name': widget.service_name,
      'description': 'Payment for ${widget.service_name}',
      'send_sms_hash': true,
      'prefill': {'contact': userPhone, 'email': userEmail},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Container(
            height: 50,
            width: 50,
            child: Center(child: CircularProgressIndicator()));
      },
    );
    final prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("user_id")!;
    final Response response =
        await AuthProvider().paymentSuccess(userId, 'true');
    // print(response.body);
    Navigator.pop(context);
    if (response.body.contains('200') || response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => Dashboard(alreadyBuild: true)),
          (Route<dynamic> route) => false);
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return PopUpResponse(
            height: ScreenUtil.defaultSize.height,
            width: ScreenUtil.defaultSize.width,
            message: 'Ok',
            rive: 'assets/Rive/sucess.riv',
            title: 'Success',
            color: Color.fromRGBO(62, 217, 111, 1),
          );
        },
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return PopUpResponse(
          height: ScreenUtil.defaultSize.height,
          width: ScreenUtil.defaultSize.width,
          message: 'Try Again',
          rive: 'assets/Rive/error_icon.riv',
          title: 'Error',
          color: Color.fromARGB(255, 255, 0, 0),
        );
      },
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }
}
