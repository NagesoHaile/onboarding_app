import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onboarding_app/features/profile/data/models/user_profile.dart';
import 'package:onboarding_app/features/profile/domain/use_cases/profile_use_case.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUseCase profileUseCase;
  ProfileBloc(this.profileUseCase) : super(ProfileInitial()) {
    on<SetupProfileEvent>(_setupProfileEventHandler);
  }

  FutureOr<void> _setupProfileEventHandler(SetupProfileEvent event, Emitter<ProfileState> emit)  async {
    // simulating network request loading
    emit(ProfileSetupLoading());
    try{
      // simulating profile setup completion(which means http request completed successfully)
      await profileUseCase.setupUserProfile(userProfile: event.userProfile);
      emit(ProfileSetupComplete(userProfile: event.userProfile));
    }catch(e){
      // simulating network request respond a failure
      emit(ProfileSetupFailed(errorMessage: 'Failed to setup profile'));
    }
  }
}
