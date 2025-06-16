part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class SetupProfileEvent extends ProfileEvent{
  final UserProfile userProfile;
 const SetupProfileEvent({required this.userProfile});
  @override
  List<Object> get props => [userProfile];
}
