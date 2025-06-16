import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_app/core/di/service_locator.dart';
import 'package:onboarding_app/core/router_config/route_name.dart';
import 'package:go_router/go_router.dart';
import 'package:onboarding_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:onboarding_app/features/profile/data/models/user_profile.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String? _selectedGoal;
  final List<String> _selectedInterests = [];

  // Available goals
  final List<String> _goals = [
    'Lose weight',
    'Find love',
    'Learn to code',
    'Get fit',
    'Start business',
    'Travel more',
  ];

  // Available interests
  final List<String> _interests = [
    'Fitness',
    'Technology',
    'Art',
    'Music',
    'Reading',
    'Cooking',
    'Travel',
    'Photography',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: const Text('Profile Created!'),
            content: const Text('Your profile has been successfully created.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.goNamed(RouteName.homePage);
                },
                child: const Text('Continue'),
              ),
            ],
          ),
    );
  }

  Future<void> _submitProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedGoal == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a goal')),
        );
        return;
      }
      if (_selectedInterests.length < 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least 2 interests')),
        );
        return;
      }

      final userProfile = UserProfile(
        name: _nameController.text,
        goals: [_selectedGoal!],
        interests: _selectedInterests,
      );

      profileBloc.add(SetupProfileEvent(userProfile: userProfile));
    }
  }

  final profileBloc = sl<ProfileBloc>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listener: (context, state) {
        if (state is ProfileSetupComplete) {
          _showSuccessDialog();
        } else if (state is ProfileSetupFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Text(
                            'Tell us about yourself',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'This helps us personalize your experience',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.textTheme.bodyLarge?.color?.withValues(
                                alpha: 0.8,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Name Field
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Your Name',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: theme.dividerColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: theme.primaryColor),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // Goal Selection
                          Text(
                            'What\'s your main goal?',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                _goals.map((goal) {
                                  final isSelected = _selectedGoal == goal;
                                  return ChoiceChip(
                                    label: Text(
                                      goal,
                                      style: TextStyle(
                                        color:
                                            isSelected
                                                ? Colors.white
                                                : theme.textTheme.bodyMedium?.color,
                                        fontWeight:
                                            isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                      ),
                                    ),
                                    selected: isSelected,
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedGoal = selected ? goal : null;
                                      });
                                    },
                                    backgroundColor: theme.cardColor,
                                    selectedColor: theme.primaryColor,
                                  );
                                }).toList(),
                          ),
                          const SizedBox(height: 32),

                          // Interests Selection
                          Text(
                            'Select your interests (2-3)',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                _interests.map((interest) {
                                  final isSelected = _selectedInterests.contains(
                                    interest,
                                  );
                                  return FilterChip(
                                    label: Text(
                                      interest,
                                      style: TextStyle(
                                        color:
                                            isSelected
                                                ? Colors.white
                                                : theme.textTheme.bodyMedium?.color,
                                        fontWeight:
                                            isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                      ),
                                    ),
                                    selected: isSelected,
                                    onSelected: (selected) {
                                      setState(() {
                                        if (selected) {
                                          if (_selectedInterests.length < 3) {
                                            _selectedInterests.add(interest);
                                          }
                                        } else {
                                          _selectedInterests.remove(interest);
                                        }
                                      });
                                    },
                                    backgroundColor: theme.cardColor,
                                    selectedColor: theme.primaryColor,
                                  );
                                }).toList(),
                          ),
                          const SizedBox(height: 48),

                          // Submit Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: state is ProfileSetupLoading ? null : _submitProfile,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: state is ProfileSetupLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : const Text(
                                      'Create Profile',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is ProfileSetupLoading)
                  Container(
                    color: Colors.black.withValues(alpha: 0.3),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

