import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FlyToCart {
  static void fly(BuildContext context, GlobalKey fromKey, String image) {
    final overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final fromBox =
        fromKey.currentContext!.findRenderObject() as RenderBox;
    final fromPos = fromBox.localToGlobal(Offset.zero, ancestor: overlay);
    final fromSize = fromBox.size;

    final toPos = Offset(40, 30);

    final entry = OverlayEntry(
      builder: (ctx) => _FlyingWidget(
        from: fromPos + Offset(fromSize.width / 2, fromSize.height / 2),
        to: toPos,
        image: image,
      ),
    );
    Overlay.of(context).insert(entry);
    Future.delayed(const Duration(milliseconds: 800), entry.remove);
  }
}

class _FlyingWidget extends StatefulWidget {
  final Offset from;
  final Offset to;
  final String image;
  const _FlyingWidget({
    required this.from,
    required this.to,
    required this.image,
  });

  @override
  State<_FlyingWidget> createState() => _FlyingWidgetState();
}

class _FlyingWidgetState extends State<_FlyingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _t;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _t = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _t,
      builder: (_, __) {
        final p = _t.value;
        final x = widget.from.dx + (widget.to.dx - widget.from.dx) * p;
        final yBase =
            widget.from.dy + (widget.to.dy - widget.from.dy) * p;
        final arc = -100 * (1 - (2 * p - 1) * (2 * p - 1));
        final y = yBase + arc;

        final scale = 1.0 - 0.6 * p;
        final opacity = 1.0 - 0.3 * p;

        return Positioned(
          left: x - 30,
          top: y - 30,
          child: Opacity(
            opacity: opacity,
            child: Transform.scale(
              scale: scale,
              child: Image.asset(widget.image, width: 60),
            ),
          ),
        );
      },
    );
  }
}