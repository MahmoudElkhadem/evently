import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/home/taps/home_tab/custom_tab_widget.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event_model.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_style.dart';
import 'package:evently/utils/dialog_utils.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/screen_utils.dart';
import 'package:evently/widgets/custom_elevated_button.dart';
import 'package:evently/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {


  int selectedIndex = 0;
  late String selectedTimeText = AppLocalizations.of(context)!.chooseTime;
  late String? selectedDateText = AppLocalizations.of(context)!.chooseDate;
  var formKey = GlobalKey<FormState>();
  var title = '';
  var description = '';
  String selectedEventImage = '';
  String selectedEventName = '';
  DateTime? selectDate;
  DateTime? selectedDateTime;
  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;

    List<String> eventNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.birthday,
    ];



    List<IconData> icons = [
      Icons.directions_bike,
      Icons.menu_book_outlined,
      Icons.museum,
      Icons.meeting_room_outlined,
      Icons.cake_outlined
    ];

    List<String> eventImageLight = [
      AppAssets.sportImageLight,
      AppAssets.bookClubImageLight,
      AppAssets.exhibitionImageLight,
      AppAssets.meetingImageLight,
      AppAssets.birthdayImageLight
    ];

    List<String> eventImageDark = [
      AppAssets.sportImageDark,
      AppAssets.bookClubImageDark,
      AppAssets.exhibitionImageDark,
      AppAssets.meetingImageDark,
      AppAssets.birthdayImageDark
    ];


    var themeProvider = Provider.of<AppThemeProvider>(context).appTheme;

    Future<void> chooseTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final now = DateTime.now();

        setState(() {
          selectedDateTime = DateTime(
            now.year,
            now.month,
            now.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          selectedTimeText = pickedTime.format(context);
        });
      }
    }


    Future<void> chooseDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(
            const Duration(days: 365)),
      );

      if (pickedDate != null) {
        setState(() {
          selectedDateText = DateFormat('yyyy/MM/dd').format(pickedDate);
          selectDate = pickedDate;
        });
      }
    }
    selectedEventImage =  themeProvider.isLight ? eventImageLight[selectedIndex] : eventImageDark[selectedIndex];

    selectedEventName = eventNameList[selectedIndex];
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: height*0.02,
                horizontal: width*0.04,
              ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                      Text(AppLocalizations.of(context)!.addEvent,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(width: width*0.35,)
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
                      selectedEventImage
                  ),
                  fit: BoxFit.fill
                ),
              ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>  SizedBox(width:5,),
                      scrollDirection: Axis.horizontal,
                      itemCount: eventNameList.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: (){
                            selectedIndex = index;
                            setState(() {

                            });
                          },
                          child: CustomTabWidget(
                             icon: icons[index],
                             isSelected: selectedIndex == index,
                             eventName: eventNameList[index],
                           ),
                        )
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  CustomTextField(
                    borderColor: Theme.of(context).dividerColor,
                    hintText: AppLocalizations.of(context)!.eventTitle,
                    hintStyle: AppStyle.regular14GreyColor,
                    fillColor: themeProvider.isDark ? AppColor.inputsDarkMode: AppColor.inputsLightMode,
                    filled: true,
                    onChanged: (text){
                      title = text!;
                    },
                    validator: (text) {
                      if(text == null || text.trim().isEmpty){
                        return "Please Enter Event Title";
                      }
                      return null;
                    },
                  ),
                  Text(AppLocalizations.of(context)!.description,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  CustomTextField(
                    borderColor: Theme.of(context).dividerColor,
                    hintText: AppLocalizations.of(context)!.eventDescription,
                    hintStyle: AppStyle.regular14GreyColor,
                    fillColor: themeProvider.isDark ? AppColor.inputsDarkMode: AppColor.inputsLightMode,
                    filled: true,
                    maxLines: 5,
                    onChanged: (text){
                      description = text!;
                    },
                    validator: (text) {
                      if(text == null || text.trim().isEmpty){
                        return "Please Enter Event Description";
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        AppLocalizations.of(context)!.eventDate,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Spacer(),
                      TextButton(
                          onPressed: (){
                            chooseDate(context);
                          },
                          child: Text(
                            selectedDateText!,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        AppLocalizations.of(context)!.eventTime,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () async {
                          chooseTime(context);
                        },
                        child: Text(
                          selectedTimeText,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  CustomElevatedButton(
                      onPressed:  (){
                        addEvent();
                      },
                      text: AppLocalizations.of(context)!.addEvent,
                      isImage: false,
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: AppColor.inputsLightMode)
                ],
              ),
            ),
          )
          )
      )
    );
  }

  void addEvent(){
    final docRef = FirebaseFirestore.instance
        .collection(EventModel.eventCollectionName)
        .doc();

    if(formKey.currentState!.validate() == true){
      // شغل الشغل يا ريس
      FirebaseUtils.addEventInFireStore(
          EventModel(
              eventID: docRef.id,
              eventImage: selectedEventImage,
              eventName: selectedEventName,
              eventTitle: title,
              eventDescription: description,
              eventCategoryIndex: selectedIndex+1,
              dateTime: DateTime(
                selectDate!.year,
                selectDate!.month,
                selectDate!.day,
                selectedDateTime!.hour,
                selectedDateTime!.minute,
              ),
          )).then(
            (value) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                snackBarAnimationStyle: AnimationStyle(duration: Duration(milliseconds: 500)),
                SnackBar(
                    content: Text(
                      AppLocalizations.of(context)!.newEventHasBeenAdded,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
      ).catchError((error) {
        DialogUtils.showMessage(
            context: context,
            text: error.toString(),
            onPressed: (){
              Navigator.pop(context);
              setState(() {

              });
            });
      });
    }
  }
}
