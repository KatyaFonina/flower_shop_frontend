import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../widgets/tap_scale.dart';
import '../widgets/top_back_button.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _controller = TextEditingController();
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('address');
    if (saved != null) _controller.text = saved;
    setState(() => _loading = false);
  }

  bool _isValid(String addr) {
    if (addr.trim().length < 8) return false;
    final lower = addr.toLowerCase();
    final hasNumber = RegExp(r'\d').hasMatch(lower);
    final hasKeyword = lower.contains('ул') ||
        lower.contains('улица') ||
        lower.contains('дом') ||
        lower.contains('д.') ||
        lower.contains('кв') ||
        lower.contains('пер') ||
        lower.contains('пр');
    return hasNumber && hasKeyword;
  }

  Future<void> _save() async {
    final text = _controller.text.trim();

    if (!_isValid(text)) {
      setState(() => _error =
          'Введите полный адрес: улица, номер дома (например: ул. Ленина, д. 5)');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', text);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Адрес сохранён!')),
    );
    Navigator.of(context).pop(true); 
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopBackButton(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your address',
                      style: AppText.koulen(26, color: AppColors.wine)),
                  const SizedBox(height: 20),

                  if (_loading)
                    const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.pinkBtn),
                    )
                  else ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.softPink,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: _error != null
                              ? AppColors.wine
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: TextField(
                        controller: _controller,
                        maxLines: 2,
                        style:
                            AppText.laila(14, color: AppColors.wine),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isCollapsed: true,
                          hintText: 'ул. Ленина, д. 5, кв. 12',
                          hintStyle: AppText.laila(13,
                              color: AppColors.wine.withOpacity(0.4)),
                        ),
                        onChanged: (_) {
                          if (_error != null) {
                            setState(() => _error = null);
                          }
                        },
                      ),
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        _error!,
                        style:
                            AppText.laila(12, color: AppColors.wine),
                      ),
                    ],
                    const SizedBox(height: 24),
                    Center(
                      child: TapScale(
                        onTap: _save,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.pinkBtn,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text('save',
                              style: AppText.laila(15,
                                  color: AppColors.cream,
                                  weight: FontWeight.w700)),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}