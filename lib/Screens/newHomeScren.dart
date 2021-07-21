import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_scroller/Screens/Product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int data = 0;
  double angle = 0;
  int data1 = 0;
  Product _product = new Product();
  List<Duration> timestamps = [];
  CarouselController productController = new CarouselController();
  VideoPlayerController videoPlayerController = new VideoPlayerController
          .network(
      'https://firebasestorage.googleapis.com/v0/b/internproj-23f10.appspot.com/o/final.mp4?alt=media&token=d2192e02-4d37-4247-bd8c-32cbc90c75d2');
  ChewieController _chewieController = new ChewieController(
      videoPlayerController: VideoPlayerController.network(
          'https://firebasestorage.googleapis.com/v0/b/internproj-23f10.appspot.com/o/final.mp4?alt=media&token=d2192e02-4d37-4247-bd8c-32cbc90c75d2'));
  @override
  void initState() {
    timestamps.add(Duration(minutes: 0, seconds: 0));
    timestamps.add(Duration(minutes: 2, seconds: 23));
    timestamps.add(Duration(minutes: 3, seconds: 26));
    timestamps.add(Duration(minutes: 4, seconds: 12));
    timestamps.add(Duration(minutes: 5, seconds: 36));
    _chewieController = new ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 20 / 10,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.red,
          backgroundColor: Colors.white,
        ),
        placeholder: Container(
          color: Colors.transparent,
        ),
        autoInitialize: true);
    super.initState();
    videoPlayerController.addListener(() {
      setState(() {
        Duration d = videoPlayerController.value.position;
        int seconds = d.inSeconds;
        if (seconds >= 0 && seconds < 143) {
          productController.animateToPage(0);
        } else if (seconds >= 143 && seconds < 206) {
          productController.animateToPage(1);
        } else if (seconds >= 206 && seconds < 252) {
          productController.animateToPage(2);
        } else if (seconds >= 252 && seconds < 336) {
          productController.animateToPage(3);
        } else if (seconds >= 336) {
          productController.animateToPage(4);
        }
      });
    });
  }

  @override
  void dispose() {
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xff0093E9), Color(0xff80D0C7)]),
        ),
        child: Stack(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Positioned(
              bottom: 300,
              child: Container(
                  decoration: BoxDecoration(),
                  height: 200,
                  child: Chewie(controller: _chewieController)),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.10,
              minChildSize: 0.10,
              maxChildSize: 0.33,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff0093E9), Color(0xff80D0C7)]),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CarouselSlider.builder(
                            carouselController: productController,
                            options: CarouselOptions(
                              height: 200,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                videoPlayerController.seekTo(timestamps[index]);
                              },
                            ),
                            itemCount: _product.productList.length,
                            itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) {
                              return Container(
                                margin: EdgeInsets.all(8),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    _product.productName[itemIndex],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        backgroundColor: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 5, color: Colors.grey)
                                    ],
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            _product.productList[itemIndex]),
                                        fit: BoxFit.cover)),
                              );
                            }),
                      ],
                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: -11,
                  child: Icon(
                    Icons.arrow_back_ios_new_sharp,
                    size: 30.0,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
