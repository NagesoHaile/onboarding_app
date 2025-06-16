import 'package:onboarding_app/features/profile/data/models/user_profile.dart';

abstract class ProfileRepository {
  Future setupUserProfile({required UserProfile userProfile});
}