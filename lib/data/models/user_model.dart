import '../../domain/entities/user_entity.dart';

/// Maps the randomuser.me JSON shape into our domain [UserEntity].
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.age,
    required super.gender,
    required super.city,
    required super.country,
    required super.thumbnailUrl,
    required super.largePhotoUrl,
    required super.isOnline,
    required super.email,
    required super.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, int index) {
    final name = json['name'] as Map<String, dynamic>? ?? {};
    final location = json['location'] as Map<String, dynamic>? ?? {};
    final picture = json['picture'] as Map<String, dynamic>? ?? {};
    final dob = json['dob'] as Map<String, dynamic>? ?? {};
    final login = json['login'] as Map<String, dynamic>? ?? {};

    return UserModel(
      id: (login['uuid'] as String?) ?? index.toString(),
      firstName: (name['first'] as String? ?? '').trim(),
      lastName: (name['last'] as String? ?? '').trim(),
      age: (dob['age'] as int?) ?? 0,
      gender: (json['gender'] as String?) ?? 'unknown',
      city: (location['city'] as String?) ?? '',
      country: (location['country'] as String?) ?? '',
      thumbnailUrl: (picture['large'] as String?) ?? '',
      largePhotoUrl: (picture['large'] as String?) ?? '',
      // API has no online flag — derive a stable pseudo-random value
      // from the index so it stays consistent across rebuilds.
      isOnline: index % 3 != 0,
      email: (json['email'] as String?) ?? '',
      phone: (json['phone'] as String?) ?? '',
    );
  }
}
