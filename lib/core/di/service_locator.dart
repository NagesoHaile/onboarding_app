import 'package:get_it/get_it.dart';
import 'package:onboarding_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:onboarding_app/features/profile/data/services/profile_service.dart';
import 'package:onboarding_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:onboarding_app/features/profile/domain/use_cases/profile_use_case.dart';
import 'package:onboarding_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';

final sl = GetIt.instance;


Future<void> serviceLocatorInit() async {
  // profile 
  sl.registerLazySingleton<ProfileService>(() => ProfileService());
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(profileService: sl()));
  sl.registerLazySingleton<ProfileUseCase>(() => ProfileUseCase(profileRepository: sl()));
  sl.registerFactory<ProfileBloc>(()=>ProfileBloc(sl()));
}