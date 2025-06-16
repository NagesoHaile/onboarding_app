import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_app/core/di/service_locator.dart';
import 'package:onboarding_app/core/theme/theme.dart';
import 'package:onboarding_app/features/profile/data/models/app_theme.dart';
import 'package:onboarding_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:onboarding_app/features/profile/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'core/router_config/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => ProfileBloc(sl())),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp.router(
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                routerConfig: router,
                themeMode:
                    state.appTheme == AppThemeMode.light
                        ? ThemeMode.light
                        : state.appTheme == AppThemeMode.dark
                        ? ThemeMode.dark
                        : ThemeMode.system,
                debugShowCheckedModeBanner: false,
              );
            },
          );
        },
      ),
    );
  }
}
