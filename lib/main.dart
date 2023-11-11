import 'package:flutter/material.dart';
import 'package:hiker/hike_detail.dart';

import 'create_hike.dart';

void main() {
  runApp(const MyApp());
}

class HikeDetail {
  int id;
  String hikeName;
  String country;
  String city;
  DateTime date;
  String hour;
  String minute;
  double length;
  double difficulty;
  String parking;
  String description;

  HikeDetail({
    required this.id,
    required this.hikeName,
    required this.country,
    required this.city,
    required this.date,
    required this.hour,
    required this.minute,
    required this.length,
    required this.difficulty,
    required this.parking,
    required this.description,
  });

  factory HikeDetail.fromSql(Map<String, dynamic> map) => HikeDetail(
        id: map['id'].toInt() ?? 0,
        hikeName: map['hikeName'] ?? '',
        country: map['country'] ?? '',
        city: map['city'] ?? '',
        date: DateTime.fromMillisecondsSinceEpoch(map['date']),
        hour: map['hour'] ?? '',
        minute: map['minute'] ?? '',
        length: double.parse(map['length']),
        difficulty: double.parse(map['difficulty']),
        parking: map['parking'] ?? '',
        description: map['description'] ?? '',
      );
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
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<HikeDetail> listHike = [];
  double totalDistance = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //bắt thao tác người dùng lên màn hình
      onTap: () {
        FocusScope.of(context).requestFocus(
            FocusNode()); //khi click ra ngoài -> bỏ focus khỏi textfield
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //màn hình không bị resize khi keyboard hiện lên, gây ra lỗi UI
        body: Column(
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
                    child: Center(
                      child: Row(
                        children: [
                          const Icon(Icons.add_road),
                          const SizedBox(width: 10),
                          const Text('Total distance'),
                          const Spacer(),
                          Text('$totalDistance km'),
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
                  return InkWell(
                    onTap: () async {
                      HikeDetail hike = await Navigator.push(
                        // Tạo 1 obj hike để hứng data từ màn HikeDetail trả về
                        context,
                        MaterialPageRoute(
                          //Navigate sang màn hike detail
                          builder: (context) => HikeDetailScreen(
                            hike: listHike[index],
                          ),
                        ),
                      );

                      //sau khi có đc data từ màn HikeDetail trả về, check xem hike đó có bị delete hay ko
                      if (hike.isDelete) {
                        listHike.removeAt(index);
                      } else {
                        //nếu ko bị delete thì update lại hike đó theo data mới
                        listHike[index] = hike;
                      }

                      //Tính lại totalDistance
                      totalDistance = 0;
                      for (hike in listHike) {
                        totalDistance += hike.length;
                      }
                      setState(() {});
                    },
                    child: BoxItem(
                      //hiển ra thông số vừa tạo bao gồm data list
                      hikeDetail: listHike[index],
                    ),
                  );
                },
              ),
            ),
            Center(
              child: IconButton(
                onPressed: () async {
                  HikeDetail hike = await Navigator.push(
                    // dùng để di chuyển giưã các màn
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const CreateHikeScreen()), //di chuyển sang Create Hike
                  );
                  listHike.add(hike); //add HIke vừa tạo vào list hike
                  totalDistance += hike.length; //cộng thêm length vào hike
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
                Text('${hikeDetail.date.toLocal()}'.split(' ')[0]),
                const Spacer(),
                Text(hikeDetail.hikeName),
                const Spacer(),
                Text('${hikeDetail.hour} hour ${hikeDetail.minute} minutes'),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Text('${hikeDetail.length.toString()} km'),
          const Spacer(),
          const Icon(Icons.navigate_next),
        ],
      ),
    );
  }
}
