import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {

  static const String eventCollectionName = 'Event';

  String eventID;
  String eventImage;
  String eventName;
  String eventTitle;
  String eventDescription;
  DateTime dateTime;
  bool isFavorite;
  int? eventCategoryIndex;

  EventModel({
    required this.eventID,
    required this.eventImage,
    required this.eventName,
    required this.eventTitle,
    required this.eventDescription,
    required this.dateTime,
    this.isFavorite = false,
    this.eventCategoryIndex
  });

  // json => object
  EventModel.fromFireStore(Map<String , dynamic > data):this(
    eventID: data['event_id'],
    eventImage: data['event_Image'],
    eventName: data['event_Name'],
    eventTitle: data['event_Title'],
    eventDescription: data['event_description'],
    dateTime: (data['date_time'] as Timestamp).toDate(),
    isFavorite: data['is_favorite'],
    eventCategoryIndex: data['event_category_index']
  );


  // object => json
  Map<String , dynamic> toFireStore(){
    return {
      'event_id': eventID,
      'event_Image': eventImage,
      'event_Name': eventName,
      'event_Title': eventTitle,
      'event_description': eventDescription,
      'date_time': dateTime,
      'event_category_index' : eventCategoryIndex,
      'is_favorite' : isFavorite,
    };
  }

}