import 'package:evently/home/taps/home_tab/event_item_widget.dart';
import 'package:evently/model/event_model.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_route.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/screen_utils.dart';
import 'package:evently/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<FavoriteTab> {
  int selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favoriteStream = FirebaseUtils.readFavoriteEventFromFireStore();
  }

  List<EventModel>  favoriteList = [];
  Stream<List<EventModel>>? favoriteStream;

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context).appTheme;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height*0.02,
          horizontal: width*0.04,
        ),
          child: Column(
            spacing: 10,
            children: [
              CustomTextField(
                filled: true,
                fillColor: themeProvider.isLight ? AppColor.inputsLightMode
                : AppColor.backgroundDarkMode,
                borderColor: AppColor.strokeDarkMode,
                sufIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
                hintText: 'Search for event',
                hintStyle: Theme.of(context).textTheme.titleSmall,
              ),

              Expanded(
                  child: StreamBuilder<List<EventModel>>(
                    stream: favoriteStream,
                    builder: (context, snapshot) {

                      if (snapshot.hasError) {

                        return Center(
                          child: Text(
                            snapshot.error.toString(),
                          ),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      }

                      final favoriteList = snapshot.data ?? [];

                      if (favoriteList.isEmpty) {
                        return const Center(
                          child: Text('Empty Event'),
                        );
                      }

                      return ListView.builder(
                        itemCount: favoriteList.length,
                        itemBuilder: (context, index) {
                          return EventItemWidget(
                            event: favoriteList[index],
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.eventDetails,
                              );
                            },
                          );
                        },
                      );
                    },
                  )
              )
            ]
          )
          ),
        );
  }
}
