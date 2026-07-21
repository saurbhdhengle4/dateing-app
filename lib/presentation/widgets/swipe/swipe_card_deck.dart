import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/user_entity.dart';
import 'swipe_profile_card.dart';

enum SwipeDirection { left, right }

class _SwipedEntry {
  const _SwipedEntry(this.user, this.direction);
  final UserEntity user;
  final SwipeDirection direction;
}

/// Tinder-style swipeable card deck: drag left to pass, right to like,
/// or tap the rose button. Keeps its own copy of [users] as the mutable
/// deck so swiping doesn't need to touch the bloc — it only reports back
/// through the callbacks.
class SwipeCardDeck extends StatefulWidget {
  const SwipeCardDeck({
    super.key,
    required this.users,
    this.onOpenProfile,
    this.onSwiped,
    this.onDeckExhausted,
  });

  final List<UserEntity> users;
  final ValueChanged<UserEntity>? onOpenProfile;
  final void Function(UserEntity user, SwipeDirection direction)? onSwiped;
  final VoidCallback? onDeckExhausted;

  @override
  State<SwipeCardDeck> createState() => _SwipeCardDeckState();
}

class _SwipeCardDeckState extends State<SwipeCardDeck> with SingleTickerProviderStateMixin {
  static const double _swipeThreshold = 110;
  static const double _velocityThreshold = 700;
  static const double _rotationFactor = 0.0035;

  late List<UserEntity> _deck;
  final List<_SwipedEntry> _history = [];

  late final AnimationController _controller;
  Animation<Offset>? _flyAnimation;
  Offset _dragOffset = Offset.zero;
  bool _dragging = false;

  @override
  void initState() {
    super.initState();
    _deck = List.of(widget.users);
    _controller = AnimationController(vsync: this)
      ..addListener(() {
        final anim = _flyAnimation;
        if (anim != null) setState(() => _dragOffset = anim.value);
      });
  }

  @override
  void didUpdateWidget(covariant SwipeCardDeck oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldIds = oldWidget.users.map((u) => u.id).toList();
    final newIds = widget.users.map((u) => u.id).toList();
    if (!listEquals(oldIds, newIds)) {
      _deck = List.of(widget.users);
      _history.clear();
      _dragOffset = Offset.zero;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    if (_controller.isAnimating) return;
    _dragging = true;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_dragging || _deck.isEmpty) return;
    setState(() => _dragOffset += details.delta);
  }

  Future<void> _onPanEnd(DragEndDetails details) async {
    if (!_dragging || _deck.isEmpty) return;
    _dragging = false;
    final dx = _dragOffset.dx;
    final vx = details.velocity.pixelsPerSecond.dx;
    if (dx > _swipeThreshold || vx > _velocityThreshold) {
      await _flyOut(SwipeDirection.right);
    } else if (dx < -_swipeThreshold || vx < -_velocityThreshold) {
      await _flyOut(SwipeDirection.left);
    } else {
      await _springBack();
    }
  }

  Future<void> _springBack() async {
    _flyAnimation = Tween<Offset>(begin: _dragOffset, end: Offset.zero)
        .chain(CurveTween(curve: Curves.easeOutBack))
        .animate(_controller);
    _controller.duration = const Duration(milliseconds: 320);
    await _controller.forward(from: 0);
    _flyAnimation = null;
    _dragOffset = Offset.zero;
  }

  Future<void> _flyOut(SwipeDirection direction) async {
    if (_deck.isEmpty || _controller.isAnimating) return;
    final screenWidth = MediaQuery.of(context).size.width;
    final end = Offset(
      direction == SwipeDirection.right ? screenWidth * 1.6 : -screenWidth * 1.6,
      _dragOffset.dy,
    );
    _flyAnimation = Tween<Offset>(begin: _dragOffset, end: end)
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(_controller);
    _controller.duration = const Duration(milliseconds: 260);
    await _controller.forward(from: 0);

    final swiped = _deck.first;
    setState(() {
      _deck.removeAt(0);
      _history.add(_SwipedEntry(swiped, direction));
      _dragOffset = Offset.zero;
      _flyAnimation = null;
    });

    widget.onSwiped?.call(swiped, direction);
    if (_deck.isEmpty) widget.onDeckExhausted?.call();
  }

  void _undo() {
    if (_history.isEmpty || _controller.isAnimating) return;
    final last = _history.removeLast();
    setState(() {
      _deck.insert(0, last.user);
      _dragOffset = Offset.zero;
    });
  }

  void _triggerLike() => _flyOut(SwipeDirection.right);

  void _showMoreSheet(UserEntity user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _MoreSheet(name: user.firstName),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_deck.isEmpty) {
      return const SizedBox.shrink();
    }

    final visible = _deck.take(3).toList();
    final stackChildren = <Widget>[];

    for (var depth = visible.length - 1; depth >= 0; depth--) {
      final user = visible[depth];
      if (depth == 0) {
        final angle = _dragOffset.dx * _rotationFactor;
        final likeOpacity = (_dragOffset.dx / _swipeThreshold).clamp(0.0, 1.0);
        final nopeOpacity = (-_dragOffset.dx / _swipeThreshold).clamp(0.0, 1.0);
        stackChildren.add(
          Positioned.fill(
            child: GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: Transform.translate(
                offset: _dragOffset,
                child: Transform.rotate(
                  angle: angle,
                  child: SwipeProfileCard(
                    user: user,
                    likeOpacity: likeOpacity,
                    nopeOpacity: nopeOpacity,
                    onTap: () => widget.onOpenProfile?.call(user),
                    onUndo: _undo,
                    onMore: () => _showMoreSheet(user),
                    onRose: _triggerLike,
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        final scale = 1 - depth * 0.045;
        final dy = depth * 14.0;
        stackChildren.add(
          Positioned.fill(
            child: IgnorePointer(
              child: Transform.translate(
                offset: Offset(0, dy),
                child: Transform.scale(scale: scale, child: SwipeProfileCard(user: user, showControls: false)),
              ),
            ),
          ),
        );
      }
    }

    return Stack(children: stackChildren);
  }
}

class _MoreSheet extends StatelessWidget {
  const _MoreSheet({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.flag_outlined, color: AppColors.error),
              title: Text('Report $name'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.block_rounded, color: AppColors.error),
              title: Text('Block $name'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.close_rounded),
              title: const Text('Cancel'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
