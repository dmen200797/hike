import 'package:flutter/material.dart';

class CreateHikeScreen extends StatefulWidget {
  const CreateHikeScreen({super.key});

  @override
  State<CreateHikeScreen> createState() => _CreateHikeScreenState();
}

List<String> listCountry = ['Vietnam', 'China', 'UK', 'Japan'];
List<String> listCity = ['Hanoi', 'Bejing', 'London', 'Tokyo'];
List<String> hours = [
  '',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12'
];
List<String> minutes = ['', '0', '15', '30', '45'];

class _CreateHikeScreenState extends State<CreateHikeScreen> {
  String countryValue = listCountry.first;
  String cityValue = listCity.first;
  String hour = hours.first;
  String minute = minutes.first;

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
          child: Column(
            children: [
              const Center(
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.lightBlue,
                      filled: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    'Name of hike:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    height: 30,
                    child: TextField(
                      style: TextStyle(
                        fontSize: 20,
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
                  const Text(
                    '*',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton(
                    value: countryValue,
                    // icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 20,
                    ),
                    underline: Container(
                      height: 2,
                      color: Colors.lightBlue,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        countryValue = value!;
                      });
                    },
                    items: listCountry.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                  const Spacer(),
                  const Text(
                    'City:',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Text(
                    '*',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton(
                    value: cityValue,
                    // icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 20,
                    ),
                    underline: Container(
                      height: 2,
                      color: Colors.lightBlue,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        cityValue = value!;
                      });
                    },
                    items: listCity.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Date:',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Text(
                    '*',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Hiking time:',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Text(
                    '*',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                  const Spacer(),
                  DropdownButton(
                    value: hour,
                    // icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 20,
                    ),
                    underline: Container(
                      height: 2,
                      color: Colors.lightBlue,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        hour = value!;
                      });
                    },
                    items: hours.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                  const Text(
                    'hours:',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  DropdownButton(
                    value: minute,
                    // icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 20,
                    ),
                    underline: Container(
                      height: 2,
                      color: Colors.lightBlue,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        minute = value!;
                      });
                    },
                    items: minutes.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),const Text(
                    'minutes:',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
