import 'package:flutter/material.dart';
import 'package:stats_animation/stats_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.deepPurple.shade900),
      home: const Home(),
    );
  }
}

const Color bgColor = Color(0xff221e22);

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  List<Stat> statList = [
    Stat(title: 'Maths', value: 56),
    Stat(title: 'Geography', value: 43),
    Stat(title: 'Science', value: 77),
    Stat(title: 'History', value: 89),
    Stat(title: 'Civics', value: 64),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (statList.isNotEmpty)
              for (int i = 0; i < statList.length; i++) ...[
                Container(
                  height: 50,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.white10),
                          top: BorderSide(color: Colors.white10))),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            statList.removeAt(i);
                          });
                        },
                        icon: const Icon(Icons.close),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 3,
                        child: Text(statList[i].title),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: Text(statList[i].value.toInt().toString()),
                      ),
                    ],
                  ),
                )
              ],
            inputBox(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: statList.length > 3
                  ? () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => StatsScreen(
                                size: MediaQuery.of(context).size.width / 1.2,
                                stats: statList,
                              )));
                    }
                  : null,
              child: const Text("Show"),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputBox() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (titleController.text.isNotEmpty &&
                    valueController.text.isNotEmpty &&
                    int.parse(valueController.text) <= 100 &&
                    statList.length < 6) {
                  statList.add(Stat(
                      title: titleController.text,
                      value: double.parse(valueController.text)));
                  titleController.clear();
                  valueController.clear();
                }
              });
            },
            icon: const Icon(Icons.add),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  hintText: 'Subject', border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: TextField(
              controller: valueController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: 'Marks / 100', border: OutlineInputBorder()),
            ),
          ),
        ],
      ),
    );
  }
}
