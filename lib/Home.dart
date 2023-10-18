import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 40, 10, 50),
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
                      Text('Quãng đường đi'),
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
                  width: 70,
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Tháng 10',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 30),
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
      ),
      height: 100,
      width: double.infinity,
      child: const Row(
        children: [
          Icon(Icons.directions_walk_outlined, size: 45),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('10-10'),
                Spacer(),
                Text('Công viên Hòa Bình'),
                Spacer(),
                Text('1 giờ 15 phút'),
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
