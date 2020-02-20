import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matrimonial/widget/profiledetailpage.dart';
import 'package:matrimonial/widget/checkboxform.dart';
import 'package:matrimonial/widget/textform.dart';
import 'package:matrimonial/widget/swiper_pagination.dart';

final TextStyle titleStyle =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0, color: Colors.white);
Map<String, String> checkboxvalue = {};
Map<String, String> castevalue = {};
Map<String, String> agevalue = {};
TextEditingController _minage;
TextEditingController _maxage;

class SearchProfile extends StatefulWidget {
  final profiles;
  SearchProfile(this.profiles);
  @override
  _SearchProfileState createState() => _SearchProfileState();
}

class _SearchProfileState extends State<SearchProfile> {
  //double _sliderValue = 18.0;
  @override
  void initState() {
    checkboxvalue = {'Mumbai': '', 'Pune': '', 'Nagpur': '', 'Other': ''};
    castevalue = {'Catholic': '', 'Protestian': '', 'Other': ''};
    agevalue = {'MinAge': '', 'MaxAge': ''};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                    onTap: () {}, child: Icon(Icons.done, size: 35)))
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Filter By Age:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Slider(
                    //   value: _sliderValue,
                    //   min: 18.0,
                    //   max: 60.0,
                    //   divisions: 6,
                    //   label: '${_sliderValue.round()}',
                    //   onChanged: (double value) {
                    //     setState(() {
                    //       _sliderValue = value;
                    //     });
                    //   },
                    // ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            // width: 200,
                            child: TextBox(_minage, 'MinAge', 'text',
                                TextInputType.number, agevalue, 1, '')),
                        Expanded(
                            //width: 200,
                            child: TextBox(_maxage, 'MaxAge', 'text',
                                TextInputType.number, agevalue, 1, ''))
                      ],
                    ),
                    Text(
                      'Filter By City:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    CheckboxForm('Mumbai', false, checkboxvalue),
                    CheckboxForm('Pune', false, checkboxvalue),
                    CheckboxForm('Nagpur', false, checkboxvalue),
                    CheckboxForm('Other', false, checkboxvalue),
                    Text(
                      'Filter By Caste:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    CheckboxForm('Catholic', false, castevalue),
                    CheckboxForm('Protestian', false, castevalue),
                    CheckboxForm('Other', false, castevalue)
                  ],
                ))));
  }
}

// Map<String, String> values = {};
// int _groupValue = -1;
// TextEditingController _minage;
// TextEditingController _maxage;
// TextEditingController _caste;
// final SwiperController _swiperController = SwiperController();
// final int _pageCount = 3;
// int _currentIndex = 0;
// final List<String> titles = [
//   "Help us to make your search easy. ",
//   "Age ",
//   "Caste "
// ];
// final List<Color> pageBgs = [
//   Colors.blue.shade300,
//   Colors.blue.shade300,
//   Colors.blue.shade300,
// ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomPadding: false,
//         backgroundColor: Colors.white,
//         body: Stack(children: <Widget>[
//           Center(
//             child: Container(
//               height: 300,
//               margin: const EdgeInsets.only(left: 8.0, right: 8.0),
//               decoration: BoxDecoration(
//                   color: Theme.of(context).accentColor,
//                   borderRadius: BorderRadius.circular(5.0)),
//             ),
//           ),
//           infoPage()
//         ]));
//   }

//   Widget infoPage() {
//     List<Widget> content = [alertBox1(), alertBox2(), alertBox3()];
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Expanded(
//             child: Swiper(
//           index: _currentIndex,
//           controller: _swiperController,
//           itemCount: _pageCount,
//           onIndexChanged: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//           loop: false,
//           itemBuilder: (context, index) {
//             return _buildPage(
//                 title: titles[index],
//                 content: content[index],
//                 pageBg: pageBgs[index]);
//           },
//           pagination: SwiperPagination(
//               builder: CustomPaginationBuilder(
//                   activeSize: Size(10.0, 20.0),
//                   size: Size(10.0, 15.0),
//                   color: Colors.grey.shade600)),
//         )),
//         SizedBox(height: 10.0),
//         _buildButtons(),
//       ],
//     );
//   }

//   Widget alertBox1() {
//     return Column(
//       children: <Widget>[
//         Text(
//           'What are you searching?',
//           style: TextStyle(fontSize: 18),
//         ),
//         RadioListTile(
//           groupValue: _groupValue,
//           title: Text("Groom"),
//           value: 0,
//           onChanged: (newValue) => setState(() {
//             _groupValue = newValue;
//             print(_groupValue);
//             values.update('for', (v) {
//               return newValue.toString();
//             });
//           }),
//         ),
//         RadioListTile(
//           title: Text("Bride"),
//           groupValue: _groupValue,
//           value: 1,
//           onChanged: (newValue) => setState(() {
//             _groupValue = newValue;
//             values.update('for', (v) {
//               return newValue.toString();
//             });
//           }),
//         ),
//       ],
//     );
//   }

//   Widget alertBox2() {
//     return Column(
//       children: <Widget>[
//         Column(
//           children: <Widget>[
//             Container(
//                 width: 200,
//                 child: TextBox(_minage, 'Min.', 'text', TextInputType.number,
//                     values, 1, '')),
//             Container(
//                 width: 200,
//                 child: TextBox(_maxage, 'Max', 'text', TextInputType.number,
//                     values, 1, ''))
//           ],
//         )
//       ],
//     );
//   }

//   Widget alertBox3() {
//     return Column(
//       children: <Widget>[
//         CheckboxForm('Romal Catholic', false, values),
//         CheckboxForm('Protestian', false, values),
//         CheckboxForm('All', false, values),
//       ],
//     );
//   }

//   Widget _buildPage({String title, Widget content, Color pageBg}) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 40.0),
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30.0), color: pageBg),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           SizedBox(height: 20.0),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: titleStyle,
//           ),
//           SizedBox(height: 30.0),
//           Expanded(child: content),
//           SizedBox(height: 50.0),
//         ],
//       ),
//     );
//   }

//   Widget _buildButtons() {
//     return Container(
//       margin: const EdgeInsets.only(right: 16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           FlatButton(
//             textColor: Colors.grey.shade600,
//             child: Text("Skip"),
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => Profiles()));
//             },
//           ),
//           IconButton(
//             icon: Icon(_currentIndex < _pageCount - 1
//                 ? Icons.arrow_forward_ios
//                 : Icons.done),
//             onPressed: () async {
//               if (_currentIndex < _pageCount - 1)
//                 _swiperController.next();
//               else {
//                 Navigator.pop(context);
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => Profiles()));
//               }
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
