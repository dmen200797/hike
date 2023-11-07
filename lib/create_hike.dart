import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hiker/main.dart';

class CreateHikeScreen extends StatefulWidget {
  const CreateHikeScreen({super.key});

  @override
  State<CreateHikeScreen> createState() => _CreateHikeScreenState();
}

List<String> listCountry = ['Vietnam', 'China', 'UK', 'Japan'];
List<String> listCity = ['Hanoi', 'Bejing', 'London', 'Tokyo'];
List<String> hours = [
  '0',
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
List<String> minutes = ['0', '15', '30', '45'];
List parkingOption = ['Yes', 'No'];

class _CreateHikeScreenState extends State<CreateHikeScreen> {
  String countryValue = listCountry.first;
  String cityValue = listCity.first;
  DateTime selectedDate = DateTime.now();
  String hour = hours.first;
  String minute = minutes.first; //=> khởi tạo ra giá trị mặc định
  double difficulty = 1;
  String parkingOpt = parkingOption[0];

  _selectDate(BuildContext context) async { //gọi ra date picker
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;// thay đổi ngày đã chọn vào biến selectedDate
      });
    }
  }

  final nameHikeController = TextEditingController(); //controller của textfield -> lấy ra giá trị user đax nhập vào textfield
  final lengthController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Future<void> showMyDialog(String text) async {
      return showDialog<void>(  //show ra pop-up Dialog cảnh báo
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alert'),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }


    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      controller: nameHikeController, //gắn controllẻr vào textfield
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.lightBlue,
                          filled: true,
                          hintText: 'Name of hike',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
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
                      '${selectedDate.toLocal()}'.split(' ')[0],
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
                    ),
                    const Text(
                      'minutes:',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Length:',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Text(
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
                        keyboardType: TextInputType.number,
                        controller: lengthController, //gắn controllẻr vào textfield
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        decoration: const InputDecoration(
                          suffixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Text('km')),
                        ),
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
                    const Text(
                      '*',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: difficulty,
                      minRating: 1,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.circle,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        difficulty = rating;
                      },
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'Parking available:',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Text(
                      '*',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: ListTile(
                        horizontalTitleGap: -10,
                        title: const Text(
                          'Yes',
                        ),
                        leading: Radio(
                          value: parkingOption[0],
                          groupValue: parkingOpt,
                          onChanged: (value) {
                            setState(() {
                              parkingOpt = value.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: ListTile(
                        horizontalTitleGap: -10,
                        title: const Text(
                          'No',
                        ),
                        leading: Radio(
                          value: parkingOption[1],
                          groupValue: parkingOpt,
                          onChanged: (value) {
                            setState(() {
                              parkingOpt = value.toString();
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
                const Text(
                  'Description:',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 150,
                  child: TextField(
                    controller: descriptionController, //gắn controllẻr vào textfield
                    maxLines: null,
                    expands: true,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 60,
                          ),
                          Text('Add photos')
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Icon(
                            Icons.videocam_rounded,
                            size: 60,
                          ),
                          Text('Add videos')
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () { //Validate dữ liệu
                          if(nameHikeController.text.isEmpty) { //lấy ra text trong textfiled, check có rỗng hay không?
                            showMyDialog('Name of Hike is missing');
                          } else if(hour == '0' && minute == '0') {
                            showMyDialog('Hiking time is missing');
                          } else if(lengthController.text.isEmpty) {
                            showMyDialog('Length is missing');
                          } else if(double.tryParse(lengthController.text) == null) { //check kiểu dữ liệu đã đúng hay chưa
                            showMyDialog('Length must be a positive number');
                          } else if(double.tryParse(lengthController.text)! < 0) {//check số âm
                            showMyDialog('Length must be a positive number');
                          } else { //nếu pass -> taoj Hike
                            HikeDetail hike = HikeDetail(
                              hikeName: nameHikeController.text, //=> Tạo hike gồm các dữ liệu phía dưới
                              country: countryValue, //gắn dữ liệu vào country (class hike detail)
                              city: cityValue,
                              date: selectedDate,
                              hour: hour,
                              minute: minute,
                              length: double.tryParse(lengthController.text) ?? 0,
                              difficulty: difficulty,
                              parking: parkingOpt,
                              description: descriptionController.text,
                              isDelete: false,
                            );
                            Navigator.pop(context,hike); //sẽ back lại màn trước và truyền Hike về màn trước(màn main)
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
