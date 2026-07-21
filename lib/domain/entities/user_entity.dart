import 'package:equatable/equatable.dart';

/// Pure domain entity — no knowledge of JSON, randomuser.me shape, etc.
class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.city,
    required this.country,
    required this.thumbnailUrl,
    required this.largePhotoUrl,
    required this.isOnline,
    required this.email,
    required this.phone,
  });

  final String id;
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final String city;
  final String country;
  final String thumbnailUrl;
  final String largePhotoUrl;
  final bool isOnline;
  final String email;
  final String phone;

  String get fullName => '$firstName $lastName';
  String get location => '$city, $country';

  @override
  List<Object?> get props => [id, firstName, lastName, age, thumbnailUrl];
}
