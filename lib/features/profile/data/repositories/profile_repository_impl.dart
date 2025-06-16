
import 'package:onboarding_app/features/profile/data/models/user_profile.dart';
import 'package:onboarding_app/features/profile/data/services/profile_service.dart';
import 'package:onboarding_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileService profileService;
  ProfileRepositoryImpl({required this.profileService});

  @override
  Future setupUserProfile({required UserProfile userProfile}) async {
     await profileService.setupUserProfile(userProfile: userProfile);
  }
}