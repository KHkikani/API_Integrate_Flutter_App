class User{
  int id;
  String firstName;
  String lastName;
  String email;
  String image;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });

  factory User.fromJSON({required Map<String,dynamic> data}){
    return User(
      id: data['id'],
        firstName: data['first_name'],
        lastName: data['last_name'],
        email: data['email'],
        image: data['avatar'],
    );
  }

}