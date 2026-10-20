import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/tap_scale.dart';
import '../widgets/top_back_button.dart';
import '../widgets/circular_logo.dart';
import '../data/api_client.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
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
                  child: Image.asset('assets/images/bg_flower.png', width: 200),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              left: -60,
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.6,
                  child: Image.asset('assets/images/bg_flower.png', width: 220),
                ),
              ),
            ),

            Column(
              children: [
                const TopBackButton(),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularLogo(size: 180),
                          const SizedBox(height: 50),
                          _PillField(hint: 'EMAIL', controller: _email),
                          const SizedBox(height: 14),
                          _PillField(
                              hint: 'PASSWORD',
                              controller: _pass,
                              obscure: true),
                          const SizedBox(height: 24),
                          TapScale(
                            onTap: () async {
                              
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => const Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.pinkBtn),
                                ),
                              );

                              try {
                                await ApiClient.login(
                                    _email.text.trim(), _pass.text);

                                if (!context.mounted) return;
                                Navigator.of(context).pop();

                                Navigator.of(context).pushReplacementNamed('/');

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Вы вошли!')),
                                );
                              } catch (e) {
                                if (!context.mounted) return;
                                Navigator.of(context).pop();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Ошибка входа: проверьте email и пароль'),
                                    backgroundColor: AppColors.wine,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: 52,
                              height: 28,
                              decoration: BoxDecoration(
                                color: AppColors.softPink,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.arrow_forward,
                                  size: 16, color: AppColors.wine),
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
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.softPink,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: AppText.laila(13, color: AppColors.wine),
        decoration: InputDecoration(
          border: InputBorder.none,
          isCollapsed: true,
          hintText: hint,
          hintStyle: AppText.laila(12, color: AppColors.wine),
        ),
      ),
    );
  }
}
