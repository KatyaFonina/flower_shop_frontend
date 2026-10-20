import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/top_back_button.dart';

class OnlineAssistantScreen extends StatelessWidget {
  const OnlineAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            const TopBackButton(),
            const SizedBox(height: 20),
            Center(
              child: Text('ONLINE ASSISTANT',
                  style: AppText.koulen(24, color: AppColors.wine)),
            ),
            const Spacer(),
            Center(
              child: Text('START A CHAT',
                  style: AppText.koulen(16,
                      color: AppColors.pinkBtn.withOpacity(0.5))),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              color: AppColors.pinkBtn,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.cream,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}