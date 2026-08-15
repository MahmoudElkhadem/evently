class Users {

  static const String collectionName = 'Users';

  String id;
  String name;
  String email;

  Users({
    required this.id,
    required this.name,
    required this.email
  });


  // object to json
  Map<String,dynamic> toFirebaseStore(){
    return {
      'id' : id,
      'name' : name,
      'email' : email
    };
  }

  // json to object
  Users.fromFirebaseStore(Map<String , dynamic > data):this(
    id : data['id'],
    name : data['name'],
    email : data['email'],
  );


}