import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

final SwiperController _swiperController = SwiperController();
final int _pageCount = 3;
int _currentIndex = 0;

List<Widget> content = [];

class ImageView extends StatefulWidget {
  final image1;
  final image2;
  final image3;
  ImageView(this.image1, this.image2, this.image3);
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    content = [
      image(widget.image1, context),
      image(widget.image2, context),
      image(widget.image3, context)
    ];
    return SimpleDialog(backgroundColor: Colors.transparent, children: <Widget>[
      Container(
          width: 200,
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(color: Colors.transparent),
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
          ))
    ]);
  }
}

Widget image(url, context) {
  return Container(
    height: MediaQuery.of(context).size.height / 2,
    width: MediaQuery.of(context).size.width,
    // margin: EdgeInsets.only(bottom: 15),

    decoration: BoxDecoration(
      color: Colors.transparent,
      //borderRadius: BorderRadius.circular(50),
      // border: Border.all(width: 1),
      image: DecorationImage(
          image: CachedNetworkImageProvider(url), fit: BoxFit.contain),
    ),
  );
}
