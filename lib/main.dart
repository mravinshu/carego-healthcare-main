import 'package:carego_healthcare/requests/auth_provider.dart';
import 'package:carego_healthcare/screens/auth/login.dart';
import 'package:carego_healthcare/screens/dashboard/dashboard.dart';
import 'package:carego_healthcare/screens/dashboard/splash_screen.dart';
import 'package:carego_healthcare/screens/service/payment_gateway.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'screens/onboarding_screen/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme:
              GoogleFonts.varelaRoundTextTheme(Theme.of(context).textTheme),
        ),
        // home: const PaymentGateway(
        //   fina_price: 1500,
        //   service_id: 100,
        //   service_name: 'covid 19 Care bdckabkjsbk cabjk hxusa',
        // ),
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const Login(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/dashboard': (context) => Dashboard(
                alreadyBuild: true,
              ),
        },
      ),
    );
  }
}

class RedirectScreen extends StatefulWidget {
  const RedirectScreen({Key? key}) : super(key: key);

  @override
  State<RedirectScreen> createState() => _RedirectScreenState();
}

class _RedirectScreenState extends State<RedirectScreen> {
  void prefren() async {
    final prefs = await SharedPreferences.getInstance();
    bool login = prefs.getBool('login') ?? false;
    if (login) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(
            alreadyBuild: false,
          ),
        ),
      );
    } else {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    prefren();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
