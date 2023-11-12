import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hiker/main.dart';

import 'database_services.dart';
import 'edit_hike.dart';

class HikeDetailScreen extends StatefulWidget {
  const HikeDetailScreen({super.key, required this.hike});

  final HikeDetail hike;

  @override
  State<HikeDetailScreen> createState() => _HikeDetailScreenState();
}

class _HikeDetailScreenState extends State<HikeDetailScreen> {
  final hikeDB = HikeDB();
  late HikeDetail currentHike;
  String countryValue = '';
  String cityValue = '';
  String hour = '';
  String minute = '';
  double difficulty = 1;
  String parkingOption = '';
  DateTime selectedDate = DateTime.now();
  String nameHike = '';
  String length = '';
  String description = '';

  @override
  void initState() {
    currentHike = widget.hike;
    countryValue = currentHike.country;
    cityValue = currentHike.city;
    hour = currentHike.hour;
    minute = currentHike.minute;
    difficulty = currentHike.difficulty;
    parkingOption = currentHike.parking;
    selectedDate = currentHike.date;
    nameHike = currentHike.hikeName;
    length = currentHike.length.toString();
    description = currentHike.description;
    super.initState();
  }

  updateData() {
    countryValue = currentHike.country;
    cityValue = currentHike.city;
    hour = currentHike.hour;
    minute = currentHike.minute;
    difficulty = currentHike.difficulty;
    parkingOption = currentHike.parking;
    selectedDate = currentHike.date;
    nameHike = currentHike.hikeName;
    length = currentHike.length.toString();
    description = currentHike.description;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, true);
          return true;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              nameHike,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Country:',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        countryValue,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 40),
                      const Text(
                        'City:',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        cityValue,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'Date:',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 30),
                      Text(
                        "${selectedDate.toLocal()}".split(' ')[0],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'Hiking time:',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '$hour hours $minute minutes',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'Length: ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '$length km',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Difficulty level:',
                        style: TextStyle(fontSize: 20),
                      ),
                      RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: difficulty,
                        itemSize: 30,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.circle,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Parking available: ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        parkingOption,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Description:',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 500,
                    height: 150,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(border: Border.all()),
                    child: Text(
                      description,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 20),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            hikeDB.delete(widget.hike.id);
                            Navigator.pop(context, true);
                          },
                          child: const Text('Delete'),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            HikeDetail hike = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditHikeScreen(
                                  hike: widget.hike,
                                ),
                              ),
                            );
                            currentHike = hike;
                            updateData();
                            setState(() {});
                          },
                          child: const Text('Edit'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
