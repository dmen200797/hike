import 'package:flutter/material.dart';

class CreateHikeScreen extends StatefulWidget {
  const CreateHikeScreen({super.key});

  @override
  State<CreateHikeScreen> createState() => _CreateHikeScreenState();
}

List<String> listCountry = ['Vietnam', 'China', 'UK', 'Japan'];
List<String> listCity = ['Hanoi', 'Bejing', 'London', 'Tokyo'];

class _CreateHikeScreenState extends State<CreateHikeScreen> {
  String countryValue = listCountry.first;
  String cityValue = listCity.first;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
