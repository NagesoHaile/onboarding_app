class UserProfile {
  final String name;
  final List<String> goals;
  final List<String> interests;

  const UserProfile({
    required this.name,
    required this.goals,
    required this.interests,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'goals': goals,
      'interests': interests,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'] as String,
      goals: List<String>.from(map['goals'] as List),
      interests: List<String>.from(map['interests'] as List),
    );
  }

  UserProfile copyWith({
    String? name,
    List<String>? goals,
    List<String>? interests,
  }) {
    return UserProfile(
      name: name ?? this.name,
      goals: goals ?? this.goals,
      interests: interests ?? this.interests,
    );
  }
}