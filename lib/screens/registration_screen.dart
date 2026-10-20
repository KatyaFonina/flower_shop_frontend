import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/tap_scale.dart';
import '../widgets/top_back_button.dart';
import '../widgets/circular_logo.dart';
import '../data/api_client.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass1 = TextEditingController();
  final _pass2 = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _pass1.dispose();
    _pass2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -60,
              right: -60,
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.6,
                  child: Image.asset(
                    'assets/images/bg_flower.png',
                    width: 200,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              left: -60,
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.6,
                  child: Image.asset(
                    'assets/images/bg_flower.png',
                    width: 220,
                  ),
                ),
              ),
            ),

            Column(
              children: [
                const TopBackButton(),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularLogo(size: 170),
                          const SizedBox(height: 40),

                          _PillField(hint: 'NAME', controller: _name),
                          const SizedBox(height: 12),
                          _PillField(hint: 'EMAIL', controller: _email),
                          const SizedBox(height: 12),
                          _PillField(
                            hint: 'PASSWORD',
                            controller: _pass1,
                            obscure: true,
                          ),
                          const SizedBox(height: 12),
                          _PillField(
                            hint: 'PASSWORD',
                            controller: _pass2,
                            obscure: true,
                          ),
                          const SizedBox(height: 24),

                          TapScale(
                            onTap: () async {
                              if (_pass1.text != _pass2.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Пароли не совпадают')),
                                );
                                return;
                              }

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => const Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.pinkBtn),
                                ),
                              );

                              try {
                                await ApiClient.register(
                                    _email.text.trim(), _pass1.text);
                                await ApiClient.login(
                                    _email.text.trim(), _pass1.text);

                                if (!context.mounted) return;
                                Navigator.of(context).pop();
                                Navigator.of(context).pushReplacementNamed('/');

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Регистрация успешна!')),
                                );
                              } catch (e) {
                                if (!context.mounted) return;
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Ошибка: ${e.toString()}'),
                                    backgroundColor: AppColors.wine,
                                  ),
                                );
                              }
                            },
                            child: const Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: AppColors.wine,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class _PillField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscure;
  const _PillField({
    required this.hint,
    required this.controller,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.softPink,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: AppText.laila(12, color: AppColors.wine),
        decoration: InputDecoration(
          border: InputBorder.none,
          isCollapsed: true,
          hintText: hint,
          hintStyle: AppText.laila(11, color: AppColors.wine),
        ),
      ),
    );
  }
}
