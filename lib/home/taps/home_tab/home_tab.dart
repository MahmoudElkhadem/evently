import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/home/taps/home_tab/custom_tab_widget.dart';
import 'package:evently/home/taps/home_tab/event_item_widget.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event_model.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_route.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;
  List<EventModel> eventList = [];
  List<EventModel> filterEventList = [];
  Stream<List<EventModel>>? eventStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventStream = getAllEventWithStream();
  }


  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    List<String> eventNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.birthday,
    ];
      List<IconData> icons = [
        Icons.grid_view_rounded,
        Icons.directions_bike,
        Icons.menu_book_outlined,
        Icons.museum,
        Icons.meeting_room_outlined,
        Icons.cake_outlined
      ];

      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height*0.02,
            horizontal: width*0.04,
          ),
          child: DefaultTabController(
            length: eventNameList.length,
            child: Column(
              spacing: 10,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.welcomeBack,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(Provider.of<UserProvider>(context).currentUser!.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    Spacer(),
                    InkWell(
                        onTap: (){
        
                        },
                        child: Icon(Icons.light_mode_outlined,
                          color: Theme.of(context).primaryColor,
                        )),
                    InkWell(
                        onTap: (){

                        },
                        child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Text('EN',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.inputsLightMode
                              ),
                            ))),
        
                  ],
                ),
                TabBar(
                  onTap: (index){
                    selectedIndex = index;
                    setState(() {

                    });
                  },
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    labelPadding: EdgeInsets.all(8),
                    tabAlignment: TabAlignment.start,
                    tabs: eventNameList.map((eventName,){
                      return CustomTabWidget(
                        icon: icons[eventNameList.indexOf(eventName)],
                        isSelected: selectedIndex == eventNameList.indexOf(eventName),
                        eventName: eventName,
                      );
                    }).toList()
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: eventStream,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        }
                        else if (snapshot.hasError){
                          return Center(
                            child: Text(snapshot.error.toString(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),);
                        }
                        else if (snapshot.hasData && snapshot.data!.isEmpty){
                          return Center(
                            child: Text('Empty Event',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),);
                        }
                        else{
                          eventList = snapshot.data!;
                          if(selectedIndex == 0){
                            filterEventList = eventList;
                            filterEventList.sort((event1, event2) {
                              return event1.dateTime.compareTo(event2.dateTime);
                            },);
                          }
                          else{
                            filterEventList = eventList.where((event) {
                              return event.eventCategoryIndex == selectedIndex;
                            },).toList();
                          }
                          return filterEventList.isEmpty ?
                          Center(
                            child: Text('Empty Click to Add Events..',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),)
                          :
                          ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(height: height*0.015,),
                            itemCount: filterEventList.length,
                            itemBuilder: (context, index) => EventItemWidget(
                              event: filterEventList[index],
                              onTap: (){
                                Navigator.pushNamed(
                                  context,
                                  AppRoute.eventDetails,
                                  arguments: filterEventList[index],
                                );
                              },
                            ),);
                        }
                      },)
                )
              ],
            ),
          ),
        ),
      );
    }


  Stream<List<EventModel>> getAllEventWithStream() {
    Stream<QuerySnapshot<EventModel>> stream = FirebaseUtils.getEventCollection().snapshots();

    return stream.map((querySnapshot){
      return querySnapshot.docs.map((doc){
      return  doc.data();
      }).toList();
    });
  }

}
