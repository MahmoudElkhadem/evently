import 'package:evently/firebase_options.dart';
import 'package:evently/home/add_event/add_event_screen.dart';
import 'package:evently/home/event_details.dart';
import 'package:evently/home/home_screen.dart';
import 'package:evently/home/update_event.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/forget_password/forget_password_screen.dart';
import 'package:evently/ui/introduction/intro_screen.dart';
import 'package:evently/ui/login/login_screen.dart';
import 'package:evently/ui/register/register_screen.dart';
import 'package:evently/ui/start_screen.dart';
import 'package:evently/utils/app_route.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>AppLanguageProvider()),
        ChangeNotifierProvider(create: (context)=>AppThemeProvider()),
        ChangeNotifierProvider(create: (context)=> UserProvider()),
      ],
      child: const EventlyApp()));
}

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});


  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Evently',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
      initialRoute: AppRoute.startScreen,
      routes: {
        AppRoute.startScreen : (context) => StartScreen(),
        AppRoute.introScreen : (context) => IntroScreen(),
        AppRoute.loginScreen : (context) => LoginScreen(),
        AppRoute.homeScreen : (context) => HomeScreen(),
        AppRoute.registerScreen : (context) => RegisterScreen(),
        AppRoute.addEventScreen : (context) => AddEventScreen(),
        AppRoute.editEvent : (context) => UpdateEvent(),
        AppRoute.eventDetails : (context) => EventDetails(),
        AppRoute.forgetPasswordScreen : (context) => ForgetPasswordScreen(),
      },
    );
  }
}