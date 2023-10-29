import 'package:flutter/material.dart';

import 'create_hike.dart';

void main() {
  runApp(const MyApp());
}

class HikeDetail {
  final String hikeName;
  final String country;
  final String city;
  final String date;
  final String time;
  final String length;
  final double difficulty;
  final String parking;
  final String description;

  HikeDetail({
    required this.hikeName,
    required this.country,
    required this.city,
    required this.date,
    required this.time,
    required this.length,
    required this.difficulty,
    required this.parking,
    required this.description,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.hike});

  final HikeDetail? hike;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HikeDetail? hike;
  List<HikeDetail> listHike = [];

  @override
  void initState() {
    hike = widget.hike;
    if (hike != null) {
      listHike.add(hike!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 3),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: const Row(
                    children: [
                      SizedBox(width: 5),
                      Icon(
                        Icons.search,
                        size: 30,
                      ),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 50,
                  height: 30,
                  child: Placeholder(),
                ),
                const Spacer(),
                const Icon(
                  Icons.calendar_month,
                  size: 45,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 50, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    height: 70,
                    width: double.infinity,
                    child: const Center(
                      child: Row(
                        children: [
                          Icon(Icons.add_road),
                          SizedBox(width: 10),
                          Text('Total distance'),
                          Spacer(),
                          Text('30,00 km'),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -10,
                    left: 30,
                    child: Container(
                      height: 20,
                      width: 90,
                      color: Colors.white,
                      child: const Center(
                        child: Text(
                          'October',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
                height: 500,
                child: ListView.builder(
                  itemCount: listHike.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BoxItem(hikeDetail: listHike[index]);
                  },
                )),
            Center(
              child: IconButton(
                onPressed: () async {
                  HikeDetail hike = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateHikeScreen()),
                  );
                  listHike.add(hike);
                  setState(() {});
                },
                icon: const Icon(
                  Icons.add_circle_outlined,
                  size: 50,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BoxItem extends StatelessWidget {
  const BoxItem({Key? key, required this.hikeDetail}) : super(key: key);
  final HikeDetail hikeDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          const Icon(
            Icons.directions_walk_outlined,
            size: 45,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(hikeDetail.date),
                const Spacer(),
                Text(hikeDetail.hikeName),
                const Spacer(),
                Text(hikeDetail.time),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Text('${hikeDetail.length} km'),
          const Spacer(),
          const Icon(Icons.navigate_next),
        ],
      ),
    );
  }
}
