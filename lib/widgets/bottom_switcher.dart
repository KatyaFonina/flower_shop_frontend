import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'tap_scale.dart';

class BottomSwitcher extends StatefulWidget {
  final ValueChanged<int>? onChanged;
  const BottomSwitcher({super.key, this.onChanged});

  @override
  State<BottomSwitcher> createState() => _BottomSwitcherState();
}

class _BottomSwitcherState extends State<BottomSwitcher> {
  int _index = 0;

  void _setIndex(int i) {
    setState(() => _index = i);
    widget.onChanged?.call(i);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cream,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        children: [
          Expanded(
            child: TapScale(
              onTap: () => _setIndex(0),
              child: _Tab(label: 'flowers', active: _index == 0),
            ),
          ),
          const SizedBox(width: 12),
          const Text('|', style: TextStyle(color: AppColors.pink)),
          const SizedBox(width: 12),
          Expanded(
            child: TapScale(
              onTap: () => _setIndex(1),
              child: _Tab(label: 'bouquet', active: _index == 1),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool active;
  const _Tab({required this.label, required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 44,
      decoration: BoxDecoration(
        color: active ? AppColors.pinkBtn : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: AppText.laila(
          15,
          color: active ? AppColors.white : AppColors.pinkLight,
        ),
      ),
    );
  }
}