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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context).appTheme;
    var height = context.height;
    var width = context.width;
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width*0.04,
                vertical: height*0.02,
            ),
            child: Form(
              key: formKey,
              child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      AppAssets.eventlyLogoLight,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      AppLocalizations.of(context)!.createYourAccount,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    CustomTextField(
                      borderColor: Theme.of(context).dividerColor,
                      filled: true,
                      fillColor: themeProvider.isDark ? AppColor.inputsDarkMode: AppColor.inputsLightMode,
                      hintText: AppLocalizations.of(context)!.enterYourName,
                      hintStyle: AppStyle.regular14GreyColor ,
                      preIcon: Icon(Icons.person_outline),
                      controller: nameController,
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return "Enter Your Name";
                        }

                        return null;
                      },
                    ),
                    CustomTextField(
                      borderColor: Theme.of(context).dividerColor,
                      filled: true,
                      fillColor: themeProvider.isDark ? AppColor.inputsDarkMode: AppColor.inputsLightMode,
                      hintText: AppLocalizations.of(context)!.enterYourEmail,
                      hintStyle: AppStyle.regular14GreyColor ,
                      preIcon: Icon(Icons.email_outlined),
                      controller: emailController,
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return "Enter Your Email";
                        }
                        final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

                        // 5. Test the input value against the regex
                        if (!emailRegex.hasMatch(emailController.text)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      borderColor: Theme.of(context).dividerColor,
                      filled: true,
                      fillColor: themeProvider.isDark ? AppColor.inputsDarkMode: AppColor.inputsLightMode,
                      hintText: AppLocalizations.of(context)!.enterYourPassword,
                      hintStyle: AppStyle.regular14GreyColor,
                      preIcon: Icon(Icons.lock_outline),
                      sufIcon: Icon(Icons.visibility_off_outlined),
                      controller: passwordController,
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return "Enter Your Password";
                        }
                        if(text.length < 6){
                          return 'Password should be at least 6 chars.';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      borderColor: Theme.of(context).dividerColor,
                      filled: true,
                      fillColor: themeProvider.isDark ? AppColor.inputsDarkMode: AppColor.inputsLightMode,
                      hintText: AppLocalizations.of(context)!.confirmYourPassword,
                      hintStyle: AppStyle.regular14GreyColor,
                      preIcon: Icon(Icons.lock_outline),
                      sufIcon: Icon(Icons.visibility_off_outlined),
                      controller: rePasswordController,
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return "Enter Your Password";
                        }
                        if(text.length < 6){
                          return 'Password should be at least 6 chars.';
                        }
                        if (text != passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),

                    CustomElevatedButton(
                      onPressed: (){
                        signUpButton();
                      },
                      text: AppLocalizations.of(context)!.signUp,
                      isImage: false,
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Theme.of(context).hintColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.alreadyHaveAnAccount,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(decoration: TextDecoration.underline),),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Theme.of(context).primaryColor,
                            indent: width*0.04,
                            endIndent: width*0.04,
                          ),
                        ),
                        Text(AppLocalizations.of(context)!.or,),
                        Expanded(
                          child: Divider(
                            color: Theme.of(context).primaryColor,
                            indent: width*0.04,
                            endIndent: width*0.04,
                          ),
                        ),
                      ],
                    ),
                    CustomElevatedButton(
                      onPressed: signInWithGoogle,
                      text: AppLocalizations.of(context)!.signUpWithGoogle,
                      isImage: true,
                      foregroundColor: Theme.of(context).primaryColor,
                      backgroundColor: themeProvider.isDark ? AppColor.strokeDarkMode : AppColor.inputsLightMode,
                      image: AppAssets.googleImage,
                    )
                  ]
              ),
            )
        ),
        )
    );
  }
  void signUpButton() async {
    if(formKey.currentState!.validate()){
      try {
        // todo: show loading
        DialogUtils.showLoading(context: context, text: 'Loading..');
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Users myUser = Users(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text
        );

        if(!mounted) return;

        FirebaseUtils.addUserInFireStore(myUser);
        var newUser = Provider.of<UserProvider>(context,listen: false);
        newUser.updateUser(myUser);

        // todo: hide loading
        DialogUtils.hideLoading(context: context);
        // todo: show success message
        DialogUtils.showMessage(
            context: context,
            text: 'Successful',
            onPressed: (){
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.homeScreen,
                    (route) => false,
              );
            });
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideLoading(context: context);

        String message;

        switch (e.code) {
          case 'email-already-in-use':
            message = 'Email is already in use';
            break;

          case 'invalid-email':
            message = 'Invalid email address';
            break;

          case 'weak-password':
            message = 'Password is too weak';
            break;

          case 'network-request-failed':
            message = 'Check your internet connection';
            break;

          default:
            message = 'Something went wrong';
        }

        DialogUtils.showMessage(
          context: context,
          text: message,
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
