import 'package:flutter/material.dart';

class ShimmerEffect extends StatefulWidget {
  const ShimmerEffect({super.key});

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect> with TickerProviderStateMixin {

   AnimationController? effectController;
   AnimationController? _shimmerController;
   Animation? effectAnimation;
  bool _isLoading = true;


  void _refresh() {
    _isLoading = true;
    effectController = AnimationController(vsync: this,duration: const Duration(seconds: 1));
    effectAnimation = ColorTween(begin: Colors.grey.shade200,end: Colors.grey.shade300).animate(effectController!)..addListener(() {
      setState(() {

      });

    });
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
    effectController!.repeat();


    Future.delayed(const Duration(seconds: 3),(){
      setState(() {
        _isLoading = false;
      });
    });

  }


@override
  void initState() {
    super.initState();
    _refresh();
  }
  @override
  void dispose() {
    _shimmerController!.dispose();
    effectController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = effectAnimation != null ? effectAnimation!.value: Colors.grey;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer effect'),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          return Future.delayed(const Duration(seconds: 0),(){
            _refresh();
          });
        },
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 20),
          itemCount: 10,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 20);
          },
          itemBuilder: (context, index) {
            return _isLoading ? effect(color): body();
          },
        ),
      ),
    );
  }

  Widget body(){
    return const Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mustamim',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              SizedBox(height: 5),
              Text('Year Designers, We\'d like to express',style: TextStyle(fontWeight: FontWeight.w500),),
              SizedBox(height: 5),
              Text('Designers, We\'d like to express our heartfelt gratitude for the tireless efforts of those who have already submitted proposals and those who are currently working on '),
            ],
          ),
        ),
      ],
    );
  }

  Widget effect(Color colors){
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: colors,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 12,
              decoration: BoxDecoration(
                color: colors,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 160,
              height: 12,
              decoration: BoxDecoration(
                color: colors,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 200,
              height: 12,
              decoration: BoxDecoration(
                color: colors,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ],
    );
  }

}