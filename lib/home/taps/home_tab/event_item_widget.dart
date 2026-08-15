import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event_model.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItemWidget extends StatefulWidget {
  const EventItemWidget({super.key,required this.onTap, required this.event});


  final void Function()? onTap;
  final EventModel event;

  @override
  State<EventItemWidget> createState() => _EventItemWidgetState();
}

class _EventItemWidgetState extends State<EventItemWidget> {
  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context).appTheme;
    return InkWell(
      onTap: widget.onTap,
      child: Container(
    height: height*0.24,
    width: double.infinity,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage(
    widget.event.eventImage
    ),
    fit: BoxFit.fill
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).scaffoldBackgroundColor
                ),
                child: Text(DateFormat('dd MMM').format(widget.event.dateTime),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).scaffoldBackgroundColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.event.eventTitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    IconButton(
                      onPressed:  (){
                        FirebaseUtils.updateIsFavorite(widget.event).
                        then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            snackBarAnimationStyle: AnimationStyle(duration: Duration(milliseconds: 500)),
                            SnackBar(
                              content: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.updateEvent,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          );
                        }
                        ).catchError(
                          (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBarAnimationStyle: AnimationStyle(duration: Duration(milliseconds: 500)),
                              SnackBar(
                                content: Text(
                                  e.toString(),
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            );
                          },
                        );
                      },
                      icon: widget.event.isFavorite ? Icon(Icons.favorite,
                        color: AppColor.redColor
                      ) :
                      Icon(Icons.favorite_border_outlined,
                        color: Theme.of(context).primaryColor,
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
