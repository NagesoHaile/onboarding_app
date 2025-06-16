import 'package:onboarding_app/features/profile/data/models/user_profile.dart';
import 'package:onboarding_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileUseCase {
  final ProfileRepository profileRepository;
  
  ProfileUseCase({required this.profileRepository});

  Future<void> setupUserProfile({required UserProfile userProfile}) async {
    await profileRepository.setupUserProfile(userProfile: userProfile);
  }
}