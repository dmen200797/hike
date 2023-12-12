import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hiker/main.dart';

import 'database_services.dart';

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
  final hikeDB = HikeDB();
  String countryValue = listCountry.first;
  String cityValue = listCity.first;
  DateTime selectedDate = DateTime.now();
  String hour = hours.first;
  String minute = minutes.first; //=> khởi tạo ra giá trị mặc định
  double difficulty = 1;
  String parkingOpt = parkingOption[0];

  _selectDate(BuildContext context) async {
    //gọi ra date picker
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked; // thay đổi ngày đã chọn vào biến selectedDate
      });
    }
  }

  final nameHikeController =
      TextEditingController(); //controller của textfield -> lấy ra giá trị user đax nhập vào textfield
  final lengthController = TextEditingController(); //controller của textfield -> lấy ra giá trị user đax nhập vào textfield
  final descriptionController = TextEditingController(); //controller của textfield -> lấy ra giá trị user đax nhập vào textfield

  Future<void> showMyDialog(String text) async {
    return showDialog<void>(
      //show ra pop-up Dialog cảnh báo
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode()); //bỏ focus ra khỏi textfield để tắt keyboard
      },
      child: Scaffold(
        body: SingleChildScrollView(//bọc scollview cho toàn màn hình
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      controller: nameHikeController,
                      //gắn controller vào textfield
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),//Bo tròn HikeName textfield
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,//Ẩn border khi focus vào textfield
                          ),
                        ),
                        fillColor: Colors.black,//đổi màu ô textfield thành màu đen
                        filled: true,
                        hintText: 'Name of hike',
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
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
                      value: countryValue, //set giá trị mặc định cho dropdown
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
                        setState(() {
                          //set lại countryValue = với giá trị đc chọn trong dropdown
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
                      value: cityValue, //set giá trị mặc định cho dropdown
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
                        setState(() {
                          //set lại cityValue = với giá trị đc chọn trong dropdown
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
                      '${selectedDate.toLocal()}'.split(' ')[0],//Tách chuỗi và lấy phần tử đầu để chỉ hiển thị ngày
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        _selectDate(context); //gọi hàm _selectDate để hiển thị DatePicker
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
                      value: hour, //set giá trị mặc định cho dropdown
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
                        setState(() {
                          //set lại hour = với giá trị đc chọn trong dropdown
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
                      value: minute, //set giá trị mặc định cho dropdown
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
                        setState(() {
                          //set lại minute = với giá trị đc chọn trong dropdown
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
                        controller: lengthController, //gắn controller vào textfield
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
                    RatingBar.builder( //build ra Rating bar
                      initialRating: difficulty, //set giá trị mặc định cho Rating bar
                      minRating: 1,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.circle,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        //set lại difficulty = với giá trị đc chọn trong rating bar
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
                    controller: descriptionController, //gắn controller vào textfield
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
                        onPressed: () {
                          //Validate dữ liệu
                          if (nameHikeController.text.isEmpty) {
                            //lấy ra text trong textfiled, check có rỗng hay không?
                            showMyDialog('Name of Hike is missing');
                          } else if (hour == '0' && minute == '0') {
                            showMyDialog('Hiking time is missing');
                          } else if (lengthController.text.isEmpty) {
                            showMyDialog('Length is missing');
                          } else if (double.tryParse(lengthController.text) ==
                              null) {
                            //check kiểu dữ liệu đã đúng hay chưa
                            showMyDialog('Length must be a positive number');
                          } else if (double.tryParse(lengthController.text)! <
                              0) {
                            //check số âm
                            showMyDialog('Length must be a positive number');
                          } else {
                            hikeDB.createHike(
                              hikeName: nameHikeController.text,
                              country: countryValue,
                              city: cityValue,
                              date: selectedDate,
                              hour: hour,
                              minute: minute,
                              length: double.parse(lengthController.text),
                              difficulty: difficulty,
                              parking: parkingOpt,
                              description: descriptionController.text,
                            );
                            Navigator.pop(context, true);
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
