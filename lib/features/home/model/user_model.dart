/// Model representing a user item fetched from the API.
class UserModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? image;
  final AddressModel? address;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.image,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      firstName: json['firstName'] ,
      lastName: json['lastName'] ,
      username: json['username'] ,
      image: json['image'] ,
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'] as Map<String, dynamic>)
          : null,
    );
  }
}

class AddressModel {
  final String? address;
  final String? city;
  final String? state;
  final String? country;

  AddressModel({this.address, this.city, this.state, this.country});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      address: json['address'] ,
      city: json['city'] ,
      state: json['state'] ,
      country: json['country'] ,
    );
  }
}


