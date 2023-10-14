import 'package:flutter/material.dart';
import 'package:stats_animation/main.dart';

class StatsScreen extends StatefulWidget {
  final double size;
  final List<Stat> stats;
  final double margin;
  const StatsScreen(
      {super.key, required this.size, required this.stats, this.margin = 4});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  bool animate = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 300)).then((_) {
      if (mounted) {
        setState(() => animate = true);
      }
    });
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          'Stats',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade900,
      ),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (Stat stat in widget.stats)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: widget.size * 0.05),
                  Text(stat.title),
                  SizedBox(height: widget.size * 0.05),
                  Container(
                    width: (widget.size / widget.stats.length) -
                        (widget.margin * 2),
                    height: widget.size,
                    margin: EdgeInsets.symmetric(horizontal: widget.margin),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          widget.size / widget.stats.length),
                      gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.01),
                            Colors.white.withOpacity(0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                      border: Border.all(
                          width: widget.margin / 2, color: Colors.white10),
                    ),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeOutExpo,
                          width: (widget.size / widget.stats.length) -
                              (widget.margin * 2),
                          height:
                              animate ? (widget.size * (stat.value / 100)) : 0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                widget.size / widget.stats.length),
                            color: Colors.white,
                          ),
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 1300),
                          curve: Curves.ease,
                          opacity: animate ? 1 : 0,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: widget.margin * 2),
                            height: (widget.size / widget.stats.length) -
                                (widget.margin * 2),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.deepPurple.shade900),
                            alignment: Alignment.center,
                            child: Text(
                              stat.title.substring(0, 1),
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize:
                                      (widget.size / widget.stats.length) / 3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}

class Stat {
  final String title;
  final double value;
  Stat({required this.title, required this.value})
      : assert(value <= 100 && value >= 0);
}
