part of 'profile_bloc.dart';

 class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

 class ProfileInitial extends ProfileState {}

class ProfileSetupLoading extends ProfileState{}

class ProfileSetupComplete extends ProfileState{
  final UserProfile userProfile;
  const ProfileSetupComplete({required this.userProfile});
    @override
  List<Object> get props => [userProfile];
}

class ProfileSetupFailed extends ProfileState{
  final String errorMessage;
  const ProfileSetupFailed({required this.errorMessage});
    @override
  List<Object> get props => [];
}