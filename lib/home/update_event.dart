import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event_model.dart';
import 'package:evently/providers/app_theme_provider.dart';
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

class UpdateEvent extends StatefulWidget {
  const UpdateEvent({super.key});

  @override
  State<UpdateEvent> createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController =
  TextEditingController();

  late EventModel event;

  int selectedIndex = 0;

  DateTime? selectDate;
  DateTime? selectedDateTime;

  String selectedDateText = '';
  String selectedTimeText = '';

  String selectedEventImage = '';
  String selectedEventName = '';

  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (isInitialized) return;

    event = ModalRoute.of(context)!.settings.arguments as EventModel;

    titleController.text = event.eventTitle;
    descriptionController.text = event.eventDescription;

    selectedIndex = (event.eventCategoryIndex ?? 1) - 1;

    selectDate = event.dateTime;
    selectedDateTime = event.dateTime;

    selectedDateText = DateFormat(
      'dd MMMM',
    ).format(event.dateTime);

    selectedTimeText = DateFormat(
      'hh:mm a',
    ).format(event.dateTime);

    selectedEventImage = event.eventImage;
    selectedEventName = event.eventName;

    isInitialized = true;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;

    final themeProvider =
        Provider.of<AppThemeProvider>(context).appTheme;

    final eventNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.birthday,
    ];

    final icons = [
      Icons.directions_bike,
      Icons.menu_book_outlined,
      Icons.museum,
      Icons.meeting_room_outlined,
      Icons.cake_outlined,
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.02,
            horizontal: width * 0.04,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [

                  // App Bar
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: themeProvider.isLight
                                ? AppColor.inputsLightMode
                                : AppColor.backgroundDarkMode,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: themeProvider.isLight
                                  ? AppColor.strokeLightMode
                                  : AppColor.strokeDarkMode,
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: themeProvider.isLight
                                ? AppColor.mainLightMode
                                : AppColor.inputsLightMode,
                          ),
                        ),
                      ),

                      const Spacer(),

                      Text(
                        AppLocalizations.of(context)!.updateEvent,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium,
                      ),

                      const Spacer(),

                      const SizedBox(width: 40),
                    ],
                  ),

                  // Event Image
                  Container(
                    height: height * 0.24,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(selectedEventImage),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  // Event Category
                  Text(
                    AppLocalizations.of(context)!.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall,
                  ),

                  SizedBox(
                    height: 55,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: eventNameList.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              selectedEventName =
                              eventNameList[index];
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? Theme.of(context).primaryColor
                                  : themeProvider.isLight
                                  ? AppColor.inputsLightMode
                                  : AppColor.backgroundDarkMode,
                              borderRadius:
                              BorderRadius.circular(12),
                              border: Border.all(
                                color: selectedIndex == index
                                    ? Theme.of(context)
                                    .primaryColor
                                    : themeProvider.isLight
                                    ? AppColor.strokeLightMode
                                    : AppColor.strokeDarkMode,
                              ),
                            ),
                            child: Row(
                              spacing: 6,
                              children: [
                                Icon(
                                  icons[index],
                                  color: selectedIndex == index
                                      ? AppColor.inputsLightMode
                                      : Theme.of(context)
                                      .primaryColor,
                                ),
                                Text(
                                  eventNameList[index],
                                  style: TextStyle(
                                    color: selectedIndex == index
                                        ? AppColor.inputsLightMode
                                        : Theme.of(context)
                                        .primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Title
                  Text(
                    'Event Title',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall,
                  ),

                  CustomTextField(
                    controller: titleController,
                    borderColor:
                    Theme.of(context).dividerColor,
                    hintText:
                    AppLocalizations.of(context)!.eventTitle,
                    hintStyle:
                    AppStyle.regular14GreyColor,
                    fillColor: themeProvider.isDark
                        ? AppColor.inputsDarkMode
                        : AppColor.inputsLightMode,
                    filled: true,
                    onChanged: (text) {},
                    validator: (text) {
                      if (text == null ||
                          text.trim().isEmpty) {
                        return 'Please Enter Event Title';
                      }
                      return null;
                    },
                  ),

                  // Date
                  Text(
                    AppLocalizations.of(context)!.eventDate,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall,
                  ),

                  InkWell(
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate:
                        selectDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate == null) return;

                      setState(() {
                        selectDate = pickedDate;

                        final oldTime =
                            selectedDateTime ??
                                event.dateTime;

                        selectedDateTime = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          oldTime.hour,
                          oldTime.minute,
                        );

                        selectedDateText = DateFormat(
                          'dd MMMM',
                        ).format(pickedDate);
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: themeProvider.isLight
                            ? AppColor.inputsLightMode
                            : AppColor.backgroundDarkMode,
                        borderRadius:
                        BorderRadius.circular(8),
                        border: Border.all(
                          color: themeProvider.isLight
                              ? AppColor.strokeLightMode
                              : AppColor.strokeDarkMode,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: Theme.of(context)
                                .primaryColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            selectedDateText,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Time
                  Text(
                    AppLocalizations.of(context)!.eventTime,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall,
                  ),

                  InkWell(
                    onTap: () async {
                      final pickedTime =
                      await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                          selectedDateTime ??
                              event.dateTime,
                        ),
                      );

                      if (pickedTime == null) return;

                      final date =
                          selectDate ?? event.dateTime;

                      setState(() {
                        selectedDateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );

                        selectedTimeText =
                            pickedTime.format(context);
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: themeProvider.isLight
                            ? AppColor.inputsLightMode
                            : AppColor.backgroundDarkMode,
                        borderRadius:
                        BorderRadius.circular(8),
                        border: Border.all(
                          color: themeProvider.isLight
                              ? AppColor.strokeLightMode
                              : AppColor.strokeDarkMode,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Theme.of(context)
                                .primaryColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            selectedTimeText,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Description
                  Text(
                    'Event Description',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall,
                  ),

                  CustomTextField(
                    controller: descriptionController,
                    borderColor:
                    Theme.of(context).dividerColor,
                    hintText: AppLocalizations.of(context)!
                        .eventDescription,
                    hintStyle:
                    AppStyle.regular14GreyColor,
                    fillColor: themeProvider.isDark
                        ? AppColor.inputsDarkMode
                        : AppColor.inputsLightMode,
                    filled: true,
                    maxLines: 5,
                    onChanged: (text) {},
                    validator: (text) {
                      if (text == null ||
                          text.trim().isEmpty) {
                        return 'Please Enter Event Description';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  // Update Button
                  CustomElevatedButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      final date =
                          selectDate ?? event.dateTime;

                      final time =
                          selectedDateTime ?? event.dateTime;

                      final updatedEvent = EventModel(
                        // مهم جدًا: نفس الـ ID القديم
                        eventID: event.eventID,

                        eventImage: selectedEventImage,

                        eventName: selectedEventName,

                        eventTitle:
                        titleController.text.trim(),

                        eventDescription:
                        descriptionController.text.trim(),

                        eventCategoryIndex:
                        selectedIndex + 1,

                        dateTime: DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        ),

                        // نحافظ على الـ Favorite القديم
                        isFavorite: event.isFavorite,
                      );

                      try {
                        await FirebaseUtils.updateEvent(
                          updatedEvent,
                        );

                        if (!context.mounted) return;

                        Navigator.pop(context);
                      } catch (error) {
                        if (!context.mounted) return;

                        DialogUtils.showMessage(
                          context: context,
                          text: error.toString(),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      }
                    },
                    text: 'Update Event',
                    isImage: false,
                    backgroundColor:
                    Theme.of(context).primaryColor,
                    foregroundColor:
                    AppColor.inputsLightMode,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}