import 'package:evently/home/taps/profile/box_item_widget.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_route.dart';
import 'package:evently/utils/screen_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTap extends StatelessWidget {
  const ProfileTap( {super.key});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width*0.04,
        vertical: height*0.04
      ),
      child: SafeArea(
        child: Column(
          spacing: height*0.01,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AppAssets.routeLogo),
            ),
            Text(
              Provider.of<UserProvider>(context).currentUser!.name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              Provider.of<UserProvider>(context).currentUser!.email,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            BoxItemWidget(
              text: AppLocalizations.of(context)!.darkMode,
              item: Switch(
                activeThumbColor: Theme.of(context).primaryColor,
                  value: themeProvider.appTheme.isDark,
                  onChanged: (value){
                    themeProvider.changeTheme(
                        value ?
                        ThemeMode.dark
                            :
                        ThemeMode.light
                    );
                  }),
            ),
            BoxItemWidget(
              text: AppLocalizations.of(context)!.language,
              item: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).primaryColor,
              )
            ),
            BoxItemWidget(
                text: AppLocalizations.of(context)!.logout,
                item: IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(context, AppRoute.loginScreen, (route) => EditableText.debugDeterministicCursor,);
                  },
                  icon : Icon(Icons.logout,
                  color: AppColor.redColor,
                  ),
                )
            ),
          ],
        ),
      ),
    )
    );
  }
}

