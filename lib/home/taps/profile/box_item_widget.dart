import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoxItemWidget extends StatelessWidget {
  const BoxItemWidget({
    super.key,
    required this.text,
    required this.item
  });

  final String text;
  final Widget item;
  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context).appTheme;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: height*0.02
      ),
      width: double.infinity,
      height: height*0.06,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: themeProvider.isDark ?
          AppColor.strokeDarkMode
              : AppColor.strokeLightMode,
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 2,
          )
      ),
      child: ListTile(
        title: Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        trailing: item,
      ),
    );
  }
}
