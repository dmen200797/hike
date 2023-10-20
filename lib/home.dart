import 'package:flutter/material.dart';
import 'package:hiker/create_hike.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: const SingleChildScrollView(
            child: Column(
              children: [
                BoxItem(),
                BoxItem(),
                BoxItem(),
                BoxItem(),
                BoxItem(),
                BoxItem(),
                BoxItem(),
              ],
            ),
          ),
        ),
         Center(
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateHikeScreen()),
              );
            },
            icon: const Icon(
              Icons.add_circle_outlined,
              size: 50,
            ),
          ),
        )
      ],
    );
  }
}

class BoxItem extends StatelessWidget {
  const BoxItem({Key? key}) : super(key: key);

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
      child: const Row(
        children: [
          Icon(Icons.directions_walk_outlined, size: 45),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('10-Oct'),
                Spacer(),
                Text('Center Park'),
                Spacer(),
                Text('1 Hours 15 minutes'),
              ],
            ),
          ),
          SizedBox(width: 20),
          Text('10,00 km'),
          Spacer(),
          Icon(Icons.navigate_next),
        ],
      ),
    );
  }
}
