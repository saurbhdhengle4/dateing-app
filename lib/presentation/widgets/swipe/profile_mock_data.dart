import 'dart:math';

import '../../../domain/entities/user_entity.dart';

/// The randomuser.me API has no match%, trust%, occupation, etc.
/// These are derived deterministically from [UserEntity.id] so a given
/// profile always shows the same details across rebuilds/undo, without
/// needing extra fields on the domain entity.
class ProfileMockData {
  const ProfileMockData({
    required this.matchPercent,
    required this.trustPercent,
    required this.replyLabel,
    required this.occupation,
    required this.heightLabel,
    required this.lookingFor,
    required this.distanceKm,
    required this.verified,
  });

  final int matchPercent;
  final int trustPercent;
  final String replyLabel;
  final String occupation;
  final String heightLabel;
  final String lookingFor;
  final int distanceKm;
  final bool verified;

  static const _occupations = [
    'Product Designer',
    'Fashion Designer',
    'Software Engineer',
    'Marketing Manager',
    'Photographer',
    'Architect',
    'Doctor',
    'Entrepreneur',
    'Content Creator',
    'Chef',
    'Musician',
    'Teacher',
    'Data Scientist',
    'Interior Designer',
    'Journalist',
  ];

  static const _heights = [
    "5'0\"", "5'1\"", "5'2\"", "5'3\"", "5'4\"", "5'5\"", "5'6\"",
    "5'7\"", "5'8\"", "5'9\"", "5'10\"", "5'11\"", "6'0\"", "6'1\"",
  ];

  static const _lookingFor = [
    'Serious relationship',
    "Let's see where it goes",
    'Long-term partner',
    'New friends',
    'Something casual',
    'Still figuring it out',
  ];

  static const _replyLabels = ['~2m Reply', '~5m Reply', '~15m Reply', '~30m Reply', '~1h Reply'];

  factory ProfileMockData.forUser(UserEntity user) {
    final rng = Random(user.id.hashCode);
    return ProfileMockData(
      matchPercent: 65 + rng.nextInt(34),
      trustPercent: 85 + rng.nextInt(15),
      replyLabel: _replyLabels[rng.nextInt(_replyLabels.length)],
      occupation: _occupations[rng.nextInt(_occupations.length)],
      heightLabel: _heights[rng.nextInt(_heights.length)],
      lookingFor: _lookingFor[rng.nextInt(_lookingFor.length)],
      distanceKm: 1 + rng.nextInt(20),
      verified: rng.nextDouble() < 0.7,
    );
  }
}
