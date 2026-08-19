class UserProfile {
  final String username;
  final String displayName;
  final String speaklyId;
  final int ratingPoints;
  final int level;
  final DateTime registrationDate;
  final bool isGhostModeEnabled;

  UserProfile({
    required this.username,
    required this.displayName,
    required this.speaklyId,
    this.ratingPoints = 0,
    this.level = 1,
    required this.registrationDate,
    this.isGhostModeEnabled = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'displayName': displayName,
      'speaklyId': speaklyId,
      'ratingPoints': ratingPoints,
      'level': level,
      'registrationDate': registrationDate.toIso8601String(),
      'isGhostModeEnabled': isGhostModeEnabled,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      username: map['username'] ?? '',
      displayName: map['displayName'] ?? '',
      speaklyId: map['speaklyId'] ?? '',
      ratingPoints: map['ratingPoints'] ?? 0,
      level: map['level'] ?? 1,
      registrationDate: map['registrationDate'] != null
          ? DateTime.parse(map['registrationDate'])
          : DateTime.now(),
      isGhostModeEnabled: map['isGhostModeEnabled'] ?? false,
    );
  }
}