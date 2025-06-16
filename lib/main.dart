import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:onboarding_app/core/di/service_locator.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';


FutureOr<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await serviceLocatorInit();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );
  runApp(const App());
}
