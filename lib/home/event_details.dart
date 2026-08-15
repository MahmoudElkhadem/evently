import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event_model.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_route.dart';
import 'package:evently/utils/app_style.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context).appTheme;
    final event = ModalRoute.of(context)!.settings.arguments as EventModel;
    return Scaffold(
      body: SafeArea(
        child: Padding(
        padding: EdgeInsets.symmetric(
        vertical: height*0.02,
        horizontal: width*0.04,
        ),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(AppLocalizations.of(context)!.eventDetails,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(width: width*0.08,),
                  InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, AppRoute.editEvent,arguments: event);
                      },
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).hoverColor),
                              color: Theme.of(context).disabledColor,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Theme.of(context).primaryColor,)
                      )
                  ),
                  InkWell(
                      onTap: () async {
                        await FirebaseUtils.deleteEvent(event);

                        Navigator.pushNamedAndRemoveUntil(context,AppRoute.homeScreen,(route) => false,);
                      },
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).hoverColor),
                              color: Theme.of(context).disabledColor,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Icon(
                            Icons.delete_outline,
                            color: AppColor.redColor,)
                      )
                  ),

                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 16,bottom: 16),
                height: height*0.24,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                      image: AssetImage(
                          event.eventImage
                      ),
                      fit: BoxFit.fill
                  ),
                ),
              ),
              Text(
                event.eventTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Container(
                width: double.infinity,
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
                child: Row(
                  spacing: 15,
                  children: [
                    Container(
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
                      child: Icon(Icons.calendar_month_outlined,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateFormat('dd MMM').format(event.dateTime),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                            DateFormat('hh:mm a').format(event.dateTime),
                            style: TextStyle(
                            color: themeProvider.isLight ? AppColor.disableColor : AppColor.textSceLightMode,
                            fontSize: 16
                          )
                        )
                      ],
                    )
                  ],
                )
              ),
              Text(AppLocalizations.of(context)!.description,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Container(
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
                child: Text(
                  event.eventDescription,
                  style: AppStyle.regular14GreyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
