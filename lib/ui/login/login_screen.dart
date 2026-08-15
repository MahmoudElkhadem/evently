import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/model.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_route.dart';
import 'package:evently/utils/app_style.dart';
import 'package:evently/utils/dialog_utils.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/screen_utils.dart';
import 'package:evently/widgets/custom_elevated_button.dart';
import 'package:evently/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider
        .of<AppThemeProvider>(context)
        .appTheme;
    var height = context.height;
    var width = context.width;
    return Scaffold(
        body: SafeArea(child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.02
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        AppAssets.eventlyLogoLight,
                        color: Theme
                            .of(context)
                            .primaryColor,
                      ),
                      Text(
                        AppLocalizations.of(context)!.loginToYourScreen,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineSmall,
                      ),
                      CustomTextField(
                        borderColor: Theme
                            .of(context)
                            .dividerColor,
                        filled: true,
                        fillColor: themeProvider.isDark ? AppColor
                            .inputsDarkMode : AppColor.inputsLightMode,
                        hintText: AppLocalizations.of(context)!.enterYourEmail,
                        hintStyle: AppStyle.regular14GreyColor,
                        preIcon: Icon(Icons.email_outlined),
                        controller: emailController,
                        validator: (text) {
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return "Enter Your Email";
                          }
                          final emailRegex = RegExp(
                              r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

                          // 5. Test the input value against the regex
                          if (!emailRegex.hasMatch(emailController.text)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        borderColor: Theme
                            .of(context)
                            .dividerColor,
                        filled: true,
                        fillColor: themeProvider.isDark ? AppColor
                            .inputsDarkMode : AppColor.inputsLightMode,
                        hintText: AppLocalizations.of(context)!
                            .enterYourPassword,
                        hintStyle: AppStyle.regular14GreyColor,
                        preIcon: Icon(Icons.lock_outline),
                        sufIcon: Icon(Icons.visibility_off_outlined),
                        controller: passwordController,
                        validator: (text) {
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return "Enter Your Password";
                          }
                          if (text.length < 6) {
                            return 'Password should be at least 6 chars.';
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoute.forgetPasswordScreen);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.forgetPassword,
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(decoration: TextDecoration
                                .underline),),
                        ),
                      ),
                      CustomElevatedButton(
                        onPressed: () {
                          loginButton();
                        },
                        text: AppLocalizations.of(context)!.login,
                        isImage: false,
                        backgroundColor: Theme
                            .of(context)
                            .primaryColor,
                        foregroundColor: Theme
                            .of(context)
                            .hintColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.doNotHaveAnAccount,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context,
                                  AppRoute.registerScreen);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signUp,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(decoration: TextDecoration
                                  .underline),),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              indent: width * 0.04,
                              endIndent: width * 0.04,
                            ),
                          ),
                          Text(AppLocalizations.of(context)!.or,),
                          Expanded(
                            child: Divider(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              indent: width * 0.04,
                              endIndent: width * 0.04,
                            ),
                          ),
                        ],
                      ),
                      CustomElevatedButton(
                        onPressed: signInWithGoogle,
                        text: AppLocalizations.of(context)!.loginWithGoogle,
                        isImage: true,
                        foregroundColor: Theme
                            .of(context)
                            .primaryColor,
                        backgroundColor: themeProvider.isDark ? AppColor
                            .strokeDarkMode : AppColor.inputsLightMode,
                        image: AppAssets.googleImage,
                      )
                    ]
                ),
              ),
            )
        ),
        )
    );
  }

  void loginButton() async {
    if (formKey.currentState!.validate()) {
      try {
        // Show loading...
        DialogUtils.showLoading(
          context: context,
          text: 'Loading..',
        );

        // 2- Login to Firebase

        print("1");

        final credential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        print("2");

        final uid = credential.user?.uid;

        if (uid == null) {
          DialogUtils.hideLoading(context: context);
          return;
        }

        final user = await FirebaseUtils.readUserFromFireStore(uid);

        print("3");

        if (!mounted) return;

        if (user == null) {
          DialogUtils.hideLoading(context: context);

          DialogUtils.showMessage(
            context: context,
            text: 'User data not found',
            onPressed: () {
              Navigator.pop(context);
            },
          );

          return;
        }

        final userProvider = Provider.of<UserProvider>(context,listen: false);

        userProvider.updateUser(user);

        // 5- Hide loading...

        DialogUtils.hideLoading(context: context);

        // 6- Show Successful Message

        DialogUtils.showMessage(
          context: context,
          text: 'Successful',
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoute.homeScreen,
                  (route) => false,
            );
          },
        );
      } on FirebaseAuthException catch (e) {

        // 7- Hide Loading...

        DialogUtils.hideLoading(context: context);

        // 8- Show Error Message

        DialogUtils.showMessage(
          context: context,
          text: e.code == 'invalid-credential'
              ? 'Something Went Wrong 💔'
              : 'Error',
          onPressed: () {
            Navigator.pop(context);
          },
        );
      }
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Show loading
      DialogUtils.showLoading(
        context: context,
        text: 'Loading..',
      );

      print("1");

      // Google Sign In
      final GoogleSignInAccount? googleUser =
      await GoogleSignIn().signIn();

      if (googleUser == null) {
        DialogUtils.hideLoading(context: context);
        return null;
      }

      print("2");

      // Google Authentication
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Firebase Credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase Login
      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      print("3");

      // Get UID
      final uid = userCredential.user?.uid;

      if (uid == null) {
        DialogUtils.hideLoading(context: context);
        return null;
      }

      // Read user from Firestore
      var user = await FirebaseUtils.readUserFromFireStore(uid);

      print("4");
      print("USER = $user");

      // لو المستخدم مش موجود في Firestore
      if (user == null) {
        final firebaseUser = userCredential.user!;

        final newUser = Users(
          id: firebaseUser.uid,
          name: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
        );

        // Add user to Firestore
        await FirebaseUtils.addUserInFireStore(newUser);

        // استخدم نفس الـ object
        user = newUser;

        print("NEW USER ADDED");
      }

      print("5");

      if (!mounted) return null;

      // Update Provider
      final userProvider =
      Provider.of<UserProvider>(
        context,
        listen: false,
      );

      userProvider.updateUser(user);

      // Hide loading
      DialogUtils.hideLoading(context: context);

      // Success
      DialogUtils.showMessage(
        context: context,
        text: 'Successful',
        onPressed: () {
          Navigator.pop(context);

          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoute.homeScreen,
                (route) => false,
          );
        },
      );

      return userCredential;

    } on FirebaseAuthException catch (e) {
      DialogUtils.hideLoading(context: context);

      print("Firebase Error: ${e.code}");

      DialogUtils.showMessage(
        context: context,
        text: e.code == 'invalid-credential'
            ? 'Something Went Wrong 💔'
            : 'Error',
        onPressed: () {
          Navigator.pop(context);
        },
      );

      return null;

    } catch (e) {
      print("Google Error: ${e.toString()}");

      DialogUtils.hideLoading(context: context);

      DialogUtils.showMessage(
        context: context,
        text: 'Something Went Wrong 💔',
        onPressed: () {
          Navigator.pop(context);
        },
      );

      return null;
    }
  }

}