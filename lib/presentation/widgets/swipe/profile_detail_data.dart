import 'dart:math';

import '../../../domain/entities/user_entity.dart';

/// One interest/hobby chip: a label plus the icon codepoint's Material name
/// isn't needed here — the widget layer maps [label] to an icon.
class InterestTag {
  const InterestTag(this.label);
  final String label;
}

/// Everything the rich profile detail screen needs beyond [ProfileMockData]
/// (which only covers what the swipe card shows). Derived deterministically
/// from [UserEntity.id] so a profile reads the same on every visit.
class ProfileDetailData {
  const ProfileDetailData({
    required this.about,
    required this.heightCm,
    required this.loveLanguage,
    required this.religion,
    required this.interestedIn,
    required this.zodiacSign,
    required this.zodiacTraits,
    required this.motherTongue,
    required this.communicationStyle,
    required this.videoIntroDuration,
    required this.educationInstitute,
    required this.educationDegree,
    required this.employmentLine,
    required this.workStyle,
    required this.ambitionLevel,
    required this.winMeOverPrompt,
    required this.bigDream,
    required this.simplePleasures,
    required this.getAlongIfPrompt,
    required this.interests,
    required this.diet,
    required this.drinking,
    required this.sleepStyle,
    required this.datingGoalTitle,
    required this.datingGoalDescription,
  });

  final String about;
  final int heightCm;
  final String loveLanguage;
  final String religion;
  final String interestedIn;
  final String zodiacSign;
  final String zodiacTraits;
  final String motherTongue;
  final String communicationStyle;
  final String videoIntroDuration;
  final String educationInstitute;
  final String educationDegree;
  final String employmentLine;
  final String workStyle;
  final String ambitionLevel;
  final String winMeOverPrompt;
  final String bigDream;
  final String simplePleasures;
  final String getAlongIfPrompt;
  final List<InterestTag> interests;
  final String diet;
  final String drinking;
  final String sleepStyle;
  final String datingGoalTitle;
  final String datingGoalDescription;

  String get heightLabel {
    final totalInches = heightCm / 2.54;
    final feet = totalInches ~/ 12;
    final inches = (totalInches % 12).round();
    return '$feet\'$inches" ($heightCm cm)';
  }

  static const _aboutTexts = [
    'Building products by day, planning my next trek by night. Looking for someone equally driven and equally curious.',
    'Coffee enthusiast, weekend hiker, and a firm believer that the best conversations happen over good food.',
    'Spend most of my time chasing deadlines and sunsets, in that order. Always up for a spontaneous plan.',
    'Equal parts ambitious and easygoing. I take my work seriously and my weekends even more seriously.',
    'Trying to read more books than I buy. Usually losing that battle. Let\'s talk about it over dinner.',
    'Here for real conversations, good playlists, and someone who won\'t judge my third coffee of the day.',
  ];

  static const _loveLanguages = [
    'Words of affirmation',
    'Quality time',
    'Acts of service',
    'Receiving gifts',
    'Physical touch',
  ];

  static const _religions = [
    'Spiritual, not religious',
    'Open to all beliefs',
    'Culturally rooted',
    'Still exploring',
    'Prefer not to say',
    'Faith matters to me',
  ];

  static const _interestedIn = ['Men', 'Women', 'Everyone'];

  static const _zodiac = [
    ['Aries', 'Bold · Direct · Energetic'],
    ['Taurus', 'Grounded · Loyal · Patient'],
    ['Gemini', 'Curious · Witty · Adaptable'],
    ['Cancer', 'Warm · Intuitive · Caring'],
    ['Leo', 'Confident · Generous · Bold'],
    ['Virgo', 'Thoughtful · Precise · Loyal'],
    ['Libra', 'Charming · Fair · Social'],
    ['Scorpio', 'Loyal · Passionate · Intuitive'],
    ['Sagittarius', 'Adventurous · Honest · Free-spirited'],
    ['Capricorn', 'Driven · Disciplined · Steady'],
    ['Aquarius', 'Independent · Original · Curious'],
    ['Pisces', 'Dreamy · Empathetic · Creative'],
  ];

  static const Map<String, String> _languageByCountry = {
    'Finland': 'Finnish',
    'Germany': 'German',
    'United Kingdom': 'English',
    'Serbia': 'Serbian',
    'Norway': 'Norwegian',
    'Ireland': 'English',
    'Mexico': 'Spanish',
    'Denmark': 'Danish',
    'France': 'French',
    'New Zealand': 'English',
    'Netherlands': 'Dutch',
    'Switzerland': 'German',
    'India': 'Hindi',
    'United States': 'English',
  };

  static const _communicationStyles = [
    'Phone calls over texts',
    'Texting throughout the day',
    'Voice notes mostly',
    'Video calls when it matters',
    'A well-timed meme',
  ];

  static const _educationOptions = [
    ['NIFT Pune', 'B. Des Fashion Design, 3rd year'],
    ['IIT Bombay', 'B.Tech Computer Science, Graduated'],
    ['University of Helsinki', 'M.Sc. Data Science'],
    ['National Institute of Design', 'B.Des Product Design'],
    ['Delhi University', 'B.A. Economics'],
    ['TU Munich', 'B.Eng Mechanical Engineering'],
    ['Trinity College Dublin', 'B.A. Business'],
    ['University of Amsterdam', 'M.A. Marketing'],
    ['Sorbonne University', 'B.A. Literature'],
    ['Culinary Institute', 'Diploma in Culinary Arts'],
  ];

  static const _employmentTypes = ['Full-time', 'Freelance', 'Part-time', 'Contract'];

  static const _workStyles = ['Creative · Hybrid', 'Remote-first', 'Structured · In-office', 'Startup hustle', '9-to-5, mostly'];

  static const _ambitionLevels = ['HIGHLY DRIVEN', 'Balanced go-getter', 'Chill achiever', 'Work to live'];

  static const _winMeOverPrompts = [
    'A good book rec and a strong chai opinion.',
    'Show up with genuine curiosity and terrible puns.',
    'A playlist that surprises me and a plan, not just "hey".',
    'Ask me about the last place I traveled to.',
    'Bring snacks. Any snacks. I\'m easy.',
  ];

  static const _bigDreams = [
    'Launch my own sustainable label — handcrafted, slow-made with heart. Also want to travel every capital city before 30.',
    'Build something that outlasts me, professionally and personally. Still figuring out the personally part.',
    'Run a small studio of my own someday, and finally learn to cook something other than pasta.',
    'Move somewhere by the coast, work remotely, and get genuinely good at surfing.',
    'Write a book someday. Currently stuck on chapter one, indefinitely.',
  ];

  static const _simplePleasures = [
    'Roadside chai after a long trek, no signal, good company.',
    'The first sip of coffee before anyone else is awake.',
    'A window seat, a good playlist, and nowhere to be.',
    'Finding a new favorite song and playing it on repeat for a week.',
    'Rainy days that come with a legitimate excuse to stay in.',
  ];

  static const _getAlongPrompts = [
    'You can debate me for an hour and still want dessert after.',
    'You don\'t take yourself too seriously, but you take kindness seriously.',
    'You\'re down for spontaneous plans and comfortable silences.',
    'You already have a go-to karaoke song.',
    'You think a good playlist says more than a good bio.',
  ];

  static const _interestPool = [
    'Travel', 'Coffee', 'Trekking', 'Books', 'Yoga', 'Indie music',
    'Cooking', 'Photography', 'Gaming', 'Fitness', 'Movies', 'Dancing',
    'Art', 'Running', 'Wine tasting', 'Gardening', 'Cycling', 'Podcasts',
  ];

  static const _diets = ['Vegetarian', 'Vegan', 'Non-vegetarian', 'Pescatarian', 'Flexitarian'];
  static const _drinking = ['Socially', 'Never', 'Regularly', 'Sober'];
  static const _sleep = ['Night owl', 'Early bird', 'Depends on the day'];

  static const _datingGoals = [
    ['Long-term, marriage-open', 'No pressure, no timelines — just looking for the right person to build something real with.'],
    ['Something casual', 'Open to seeing where it goes without putting a label on it too soon.'],
    ['Still figuring it out', 'New to this, keeping an open mind and taking it one date at a time.'],
    ['New friends first', 'Happy to start as friends and let things unfold naturally.'],
    ['Let\'s see where it goes', 'Not chasing a timeline, just good company and honest connection.'],
  ];

  factory ProfileDetailData.forUser(UserEntity user) {
    final rng = Random(user.id.hashCode);
    final zodiac = _zodiac[rng.nextInt(_zodiac.length)];
    final goal = _datingGoals[rng.nextInt(_datingGoals.length)];
    final education = _educationOptions[rng.nextInt(_educationOptions.length)];
    final shuffledInterests = List.of(_interestPool)..shuffle(rng);

    return ProfileDetailData(
      about: _aboutTexts[rng.nextInt(_aboutTexts.length)],
      heightCm: 152 + rng.nextInt(40),
      loveLanguage: _loveLanguages[rng.nextInt(_loveLanguages.length)],
      religion: _religions[rng.nextInt(_religions.length)],
      interestedIn: _interestedIn[rng.nextInt(_interestedIn.length)],
      zodiacSign: zodiac[0],
      zodiacTraits: zodiac[1],
      motherTongue: _languageByCountry[user.country] ?? 'English',
      communicationStyle: _communicationStyles[rng.nextInt(_communicationStyles.length)],
      videoIntroDuration: '0:${10 + rng.nextInt(50)}',
      educationInstitute: education[0],
      educationDegree: education[1],
      employmentLine: '${_employmentTypes[rng.nextInt(_employmentTypes.length)]} · ${1 + rng.nextInt(15)} yrs exp',
      workStyle: _workStyles[rng.nextInt(_workStyles.length)],
      ambitionLevel: _ambitionLevels[rng.nextInt(_ambitionLevels.length)],
      winMeOverPrompt: _winMeOverPrompts[rng.nextInt(_winMeOverPrompts.length)],
      bigDream: _bigDreams[rng.nextInt(_bigDreams.length)],
      simplePleasures: _simplePleasures[rng.nextInt(_simplePleasures.length)],
      getAlongIfPrompt: _getAlongPrompts[rng.nextInt(_getAlongPrompts.length)],
      interests: shuffledInterests.take(6 + rng.nextInt(3)).map(InterestTag.new).toList(),
      diet: _diets[rng.nextInt(_diets.length)],
      drinking: _drinking[rng.nextInt(_drinking.length)],
      sleepStyle: _sleep[rng.nextInt(_sleep.length)],
      datingGoalTitle: goal[0],
      datingGoalDescription: goal[1],
    );
  }
}
