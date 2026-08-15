import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_route.dart';
import 'package:evently/utils/app_style.dart';
import 'package:evently/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = context.height;
    var width = context.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width*0.04,
            vertical: height*0.02,
          ),
          child: Column(
            spacing: 20,
            children: [
              Image.asset(
                AppAssets.eventlyLogoLight,
                color: Theme.of(context).primaryColor,
              ),
              Expanded(
                flex: 3,
                child:
                Column(
                    children: [
                      Image.asset(
                        AppAssets.intro1,
                        fit: BoxFit.fill,
                      ),
                    ],
        ),
      ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.startTitle,
                  style: Theme.of(context).textTheme.headlineLarge
                ),

                const SizedBox(height: 10),

                Text(
                  AppLocalizations.of(context)!.startCaption,
                  style: Theme.of(context).textTheme.bodyLarge
                ),
                    ]
                    ),
        ),
              Row(
                spacing: 8,
                  children:[
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight(500)
                      ),
                    ),
                    Spacer(),
                    InkWell(
                        onTap: (){
                          languageProvider.changeLanguage('en');
                        },
                      child: languageProvider.appLanguage == 'en'?
                          selectedLanguage(AppLocalizations.of(context)!.english):
                          unSelectedLanguage(AppLocalizations.of(context)!.english),
                    ),
                    InkWell(
                      onTap: (){
                        languageProvider.changeLanguage('ar');
                      },
                      child: languageProvider.appLanguage == 'ar'?
                      selectedLanguage(AppLocalizations.of(context)!.arabic):
                      unSelectedLanguage(AppLocalizations.of(context)!.arabic),
                    ),
                  ]
              ),
              Row(
                spacing: 8,
                  children:[
                    Text(
                      AppLocalizations.of(context)!.theme,
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight(500)
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: (){
                        themeProvider.changeTheme(ThemeMode.light);
                      },
                      child: themeProvider.appTheme == ThemeMode.light ?
                      selectedTheme():
                      unSelectedTheme(),
                    ),
                    InkWell(
                      onTap: (){
                        themeProvider.changeTheme(ThemeMode.dark);
                      },
                      child: themeProvider.appTheme == ThemeMode.dark ?
                      selectedTheme():
                      unSelectedTheme(),
                    ),
                  ]
              ),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.introScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: AppColor.inputsLightMode,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.letsStart,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
        ],
          ),
    )
      )
    );
  }

  Widget selectedLanguage(String language){
    return
        Container(
          alignment: Alignment.center,
          height: context.height*0.04,
          width: context.width*0.2,
          decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.strokeLightMode,width: 2),
            color: Theme.of(context).primaryColor,
              ),
            child: Text(
              language,
              style: AppStyle.regular14whiteColor
          ),
        );
  }
  Widget unSelectedLanguage(String language){
    return
      Container(
        alignment: Alignment.center,
        height: context.height*0.04,
        width: context.width*0.2,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.strokeLightMode,width: 2),
            borderRadius: BorderRadius.circular(8),
            color: AppColor.inputsLightMode
        ),
        child: Text(
          language,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColor.mainLightMode
          ),
        ),
      );
  }

  Widget selectedTheme(){
    return Container(
      width: context.width* 0.14,
      height: context.height* 0.04,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: AppColor.strokeLightMode,
              width: 2
          )
      ),
      child: Icon(
        Icons.sunny,
        color: AppColor.inputsLightMode,
      ),
    );
  }

  Widget unSelectedTheme(){
    return Container(
      width: context.width* 0.14,
      height: context.height* 0.04,
      decoration: BoxDecoration(
        color: AppColor.inputsLightMode,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: AppColor.strokeLightMode,
          width: 2
        )
      ),
      child: Icon(
        Icons.nightlight_outlined,
        color: AppColor.mainLightMode,
      ),
    );
  }
}
