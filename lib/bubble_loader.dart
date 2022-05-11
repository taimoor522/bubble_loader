library bubble_loader;

import 'package:flutter/material.dart';

class BubbleLoader extends StatefulWidget {
  final Color color1;
  final Color color2;
  final double bubbleScalingFactor;
  final double bubbleGap;
  final Duration duration;

  const BubbleLoader({
    Key? key,
    required this.color1,
    required this.color2,
    this.bubbleScalingFactor = 1,
    this.bubbleGap = 10,
    this.duration = const Duration(milliseconds: 1500),
  }) : super(key: key);

  @override
  State<BubbleLoader> createState() => _BubbleLoaderState();
}

class _BubbleLoaderState extends State<BubbleLoader>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _firstBubbleOffSetAnimation;
  late Animation<double> _firstBubbleScaleAnimation;
  late Animation<Offset> _secondBubbleOffSetAnimation;
  late Animation<double> _secondBubbleScaleAnimation;
  bool _reverse = false;
  final double _size = 50;

  @override
  void initState() {
    super.initState();

    /// Initialize Animation Controller
    _controller = AnimationController(vsync: this, duration: widget.duration);

    /// Offset Animation for First Bubble
    _firstBubbleOffSetAnimation =
        TweenSequence<Offset>(<TweenSequenceItem<Offset>>[
          TweenSequenceItem(
            tween: Tween<Offset>(
                begin: const Offset(0, 0), end: Offset(widget.bubbleGap + 10, 0)),
            weight: 1,
          ),
          TweenSequenceItem(
            tween: Tween<Offset>(
                begin: Offset(widget.bubbleGap + 10, 0), end: const Offset(0, 0)),
            weight: 1,
          ),
          TweenSequenceItem(
            tween: Tween<Offset>(
                begin: const Offset(0, 0),
                end: Offset(-(widget.bubbleGap + 10), 0)),
            weight: 1,
          ),
          TweenSequenceItem(
            tween: Tween<Offset>(
                begin: Offset(-(widget.bubbleGap + 10), 0),
                end: const Offset(0, 0)),
            weight: 1,
          ),
        ]).animate(_controller);

    /// Scale Animation for First Bubble
    _firstBubbleScaleAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 1 * widget.bubbleScalingFactor,
          end: 0.8 * widget.bubbleScalingFactor,
        ),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 0.8 * widget.bubbleScalingFactor,
          end: 0.5 * widget.bubbleScalingFactor,
        ),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 0.5 * widget.bubbleScalingFactor,
          end: 0.8 * widget.bubbleScalingFactor,
        ),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 0.8 * widget.bubbleScalingFactor,
          end: 1 * widget.bubbleScalingFactor,
        ),
        weight: 1,
      ),
    ]).animate(_controller);

    /// Offset Animation for Second Bubble
    _secondBubbleOffSetAnimation =
        TweenSequence<Offset>(<TweenSequenceItem<Offset>>[
          TweenSequenceItem(
            tween: Tween<Offset>(
                begin: const Offset(0, 0),
                end: Offset(-(widget.bubbleGap + 10), 0)),
            weight: 1,
          ),
          TweenSequenceItem(
            tween: Tween<Offset>(
                begin: Offset(-(widget.bubbleGap + 10), 0),
                end: const Offset(0, 0)),
            weight: 1,
          ),
          TweenSequenceItem(
            tween: Tween<Offset>(
                begin: const Offset(0, 0), end: Offset(widget.bubbleGap + 10, 0)),
            weight: 1,
          ),
          TweenSequenceItem(
            tween: Tween<Offset>(
                begin: Offset(widget.bubbleGap + 10, 0), end: const Offset(0, 0)),
            weight: 1,
          ),
        ]).animate(_controller);

    /// Scake Animation for Second Bubble
    _secondBubbleScaleAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 0.5 * widget.bubbleScalingFactor,
          end: 0.8 * widget.bubbleScalingFactor,
        ),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 0.8 * widget.bubbleScalingFactor,
          end: 1 * widget.bubbleScalingFactor,
        ),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
            begin: 1 * widget.bubbleScalingFactor,
            end: 0.8 * widget.bubbleScalingFactor),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 0.8 * widget.bubbleScalingFactor,
          end: 1 * widget.bubbleScalingFactor,
        ),
        weight: 1,
      ),
    ]).animate(_controller);

    /// Add listner to the Controller
    _controller
      ..addListener(() {
        /// when first bubble start to scale down, bring the second bubble to front
        if (_firstBubbleOffSetAnimation.value.dx > 10 + widget.bubbleGap - 5) {
          _reverse = true;
        }

        /// when second bubble start to scale down, bring the first bubble to front
        if (_secondBubbleOffSetAnimation.value.dx > 10 + widget.bubbleGap - 5) {
          _reverse = false;
        }
        setState(() {});
      })

    /// keeps the Animation running forever
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_reverse)
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..translate(_firstBubbleOffSetAnimation.value.dx,
                    _firstBubbleOffSetAnimation.value.dy)
                ..scale(_firstBubbleScaleAnimation.value),
              child: Container(
                width: _size,
                height: _size,
                decoration: BoxDecoration(
                  color: widget.color1,
                  shape: BoxShape.circle,
                ),
                child: const SizedBox.shrink(),
              ),
            ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..translate(_secondBubbleOffSetAnimation.value.dx,
                  _secondBubbleOffSetAnimation.value.dy)
              ..scale(_secondBubbleScaleAnimation.value),
            child: Container(
              width: _size,
              height: _size,
              decoration: BoxDecoration(
                color: widget.color2,
                shape: BoxShape.circle,
              ),
              child: const SizedBox.shrink(),
            ),
          ),
          if (!_reverse)
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..translate(_firstBubbleOffSetAnimation.value.dx,
                    _firstBubbleOffSetAnimation.value.dy)
                ..scale(_firstBubbleScaleAnimation.value),
              child: Container(
                width: _size,
                height: _size,
                decoration: BoxDecoration(
                  color: widget.color1,
                  shape: BoxShape.circle,
                ),
                child: const SizedBox.shrink(),
              ),
            ),
        ],
      ),
    );
  }

  /// Dispose the Animation Controller
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
