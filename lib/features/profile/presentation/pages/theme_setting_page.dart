import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_app/features/profile/presentation/blocs/theme_bloc/theme_bloc.dart';

class ThemeSettingPage extends StatelessWidget {
  const ThemeSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Column(
              children: [
                _buildThemeModeOption(
                  context,
                ),
                // const Divider(height: 1),
                // _buildThemeModeOption(
                //   context,
                //   'Dark',
                //   Icons.dark_mode,
                //   ThemeMode.dark,
                //   isSelected: Theme.of(context).brightness == Brightness.dark
                // ),
                // const Divider(height: 1),
                // _buildThemeModeOption(
                //   context,
                //   'System',
                //   Icons.brightness_auto,
                //   ThemeMode.system,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeModeOption(
    BuildContext context,
  ) {
    String title = Theme.of(context).brightness == Brightness.dark ? "Dark":"Light";
    return ListTile(
      leading: Icon(
        Theme.of(context).brightness == Brightness.dark?  Icons.light_mode:Icons.dark_mode ,
      ),
      title: Text(title),
    
      onTap: () {
        context.read<ThemeBloc>().add(ThemeEvent());
      },
    );
  }
}