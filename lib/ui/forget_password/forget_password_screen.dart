import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/screen_utils.dart';
import 'package:evently/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context).appTheme;
    var height = context.height;
    var width = context.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02
        ),
        child: SafeArea(
          child: Column(
            spacing: 40,
            children: [
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: themeProvider.isLight ? AppColor.inputsLightMode
                              : AppColor.backgroundDarkMode,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: themeProvider.isLight ? AppColor.strokeLightMode
                                  : AppColor.strokeDarkMode
                          )
                      ),
                      child: Icon(Icons.arrow_back_ios_new,
                        color: themeProvider.isLight ? AppColor.mainLightMode
                            : AppColor.inputsLightMode,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(AppLocalizations.of(context)!.forgetPassword,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(width: width*0.24,)
                ],
              ),
              Image.asset(AppAssets.forgetPassword),
              CustomElevatedButton(
                  onPressed: (){

                  },
                  text: AppLocalizations.of(context)!.resetPassword,
                  isImage: false,
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).hintColor,)
            ],
          ),
        ),
      ),
    );
  }
}
