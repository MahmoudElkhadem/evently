import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/event_model.dart';
import 'package:evently/model/model.dart';

class FirebaseUtils {
  static CollectionReference<Users> getUserCollection(){
     return FirebaseFirestore.instance.collection(Users.collectionName)
    .withConverter(
       fromFirestore: (snapshot, options) {
      return Users.fromFirebaseStore(snapshot.data()!);
      },
       toFirestore: (user, options) => user.toFirebaseStore(),
     );
  }

  static CollectionReference<EventModel> getEventCollection() {
    return FirebaseFirestore.instance.collection(EventModel.eventCollectionName)
        .withConverter(
        fromFirestore: (snapshot, options) => EventModel.fromFireStore(snapshot.data()!),
        toFirestore:  (event, options) => event.toFireStore()
    );
  }


  //////////////////////////////////////////////////////////////////


  static Future<void> addUserInFireStore(Users myUser) async {
    CollectionReference<Users> collectionRefer = getUserCollection();

    DocumentReference<Users> myDoc =
    collectionRefer.doc(myUser.id);

    await myDoc.set(myUser);
  }

  static Future<void> addEventInFireStore(EventModel myEvent) async{
    CollectionReference<EventModel> collectionRefer = getEventCollection();

    DocumentReference<EventModel> myDoc = collectionRefer.doc(myEvent.eventID);
    return await myDoc.set(myEvent);
  }


  //////////////////////////////////////////////////////////////////


  static Future<Users?> readUserFromFireStore(String uId) async {
    DocumentSnapshot<Users> querySnapshot = await getUserCollection().doc(uId).get();
    return querySnapshot.data();
  }

  static Future<EventModel?> readEventFromFireStore(String uId) async {
    DocumentSnapshot<EventModel> querySnapshot = await getEventCollection().doc(uId).get();
    return querySnapshot.data();

  }

  //////////////////////////////////////////////////////////////////


  static Future<void>updateIsFavorite (EventModel event){
    return getEventCollection().doc(event.eventID).update(
        {'is_favorite' : !event.isFavorite});
  }

  //////////////////////////////////////////////////////////////////

  static Stream<List<EventModel>> readFavoriteEventFromFireStore()  {
    return getEventCollection().
    where('is_favorite',isEqualTo: true).
        orderBy('date_time').snapshots().map(
            (querySnapshot) {
              return querySnapshot.docs.map((doc){
                return doc.data();
              }).toList();
            });

  }

  //////////////////////////////////////////////////////////////////


  static Future<void> deleteEvent(EventModel event) async {
    await getEventCollection()
        .doc(event.eventID)
        .delete();
  }


  static Future<void> updateEvent(EventModel event) async {
    await getEventCollection()
        .doc(event.eventID)
        .set(event);
  }

}