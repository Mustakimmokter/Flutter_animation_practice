import 'package:flutter/material.dart';
import 'package:flutter_animation_practice/featured/ui/shimer_effect/card_list.dart';
import 'package:flutter_animation_practice/featured/ui/shimer_effect/circle_container.dart';
import 'package:flutter_animation_practice/featured/ui/shimer_effect/shimer.dart';
import 'package:flutter_animation_practice/featured/ui/shimer_effect/shimer_loading.dart';


const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

class ExampleUiLoadingAnimation extends StatefulWidget {
  const ExampleUiLoadingAnimation({
    super.key,
  });

  @override
  State<ExampleUiLoadingAnimation> createState() =>
      _ExampleUiLoadingAnimationState();
}

class _ExampleUiLoadingAnimationState extends State<ExampleUiLoadingAnimation> {
  bool _isLoading = true;

  Future<void> _toggleLoading()async {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 3),(){
      setState(() {
        _isLoading = false;
      });
    });
  }


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      _isLoading = false;
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer(
        linearGradient: _shimmerGradient,
        child: ListView(
          physics: _isLoading ? const NeverScrollableScrollPhysics() : null,
          children: [
            const SizedBox(height: 16),
            SizedBox(
              height: 72,
              child: ListView(
                physics: _isLoading ? const NeverScrollableScrollPhysics() : null,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: List.generate(8, (index) {
                  return ShimmerLoading(
                    isLoading: _isLoading,
                    child: CircleContainer(),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: List.generate(5, (index) {
                return ShimmerLoading(
                  isLoading: _isLoading,
                  child: CardListItem(
                    isLoading: _isLoading,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleLoading,
        child: Icon(
          _isLoading ? Icons.hourglass_full : Icons.hourglass_bottom,
        ),
      ),
    );
  }




}
