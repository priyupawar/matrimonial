import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:matrimonial/widget/profiledetailpage.dart';
import 'package:matrimonial/widget/swiper_pagination.dart';
import 'package:matrimonial/forms/searchprofile.dart';

final SwiperController _swiperController = SwiperController();
final int _pageCount = 2;
int _currentIndex = 0;

class SwiperPage extends StatefulWidget {
  final profile;
  SwiperPage(this.profile);
  @override
  _SwiperPageState createState() => _SwiperPageState();
}

class _SwiperPageState extends State<SwiperPage> {
  @override
  Widget build(BuildContext context) {
    return swiper(widget.profile);
  }

  Widget swiper(profile) {
    List<Widget> content = [
      personal(profile),
      education(profile),
      // personal(profile)
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
            child: Swiper(
          index: _currentIndex,
          controller: _swiperController,
          itemCount: _pageCount,
          onIndexChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          loop: false,
          itemBuilder: (context, index) {
            return content[index];
          },
          // pagination: SwiperPagination(
          //     builder: CustomPaginationBuilder(
          //         activeSize: Size(10.0, 20.0),
          //         size: Size(10.0, 15.0),
          //         color: Colors.grey.shade600)),
        )),
        //SizedBox(height: 10.0),
        //_buildButtons(),
      ],
    );
  }

  // Widget _buildButtons() {
  //   return Container(
  //     margin: const EdgeInsets.only(right: 16.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: <Widget>[
  //         FlatButton(
  //           textColor: Colors.grey.shade600,
  //           child: Text("Skip"),
  //           onPressed: () {
  //             Navigator.pop(context);
  //             Navigator.push(
  //                 context, MaterialPageRoute(builder: (context) => Profiles()));
  //           },
  //         ),
  //         IconButton(
  //           icon: Icon(_currentIndex < _pageCount - 1
  //               ? Icons.arrow_forward_ios
  //               : Icons.done),
  //           onPressed: () async {
  //             if (_currentIndex < _pageCount - 1)
  //               _swiperController.next();
  //             else {
  //               Navigator.pop(context);
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => Profiles()));
  //             }
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }
}
