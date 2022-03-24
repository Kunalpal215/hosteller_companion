import 'dart:async';

import 'package:brahmo/screens/item_issue/item_choice_search.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int carouselIndex = 0;
  StreamController carouselController = StreamController();

  @override
  void dispose() {
    super.dispose();
    carouselController.close();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Widget NewsCarouselMaker(){
    //   // to fetch news headlines from firebase
    //   return FutureBuilder(
    //     future: ,
    //   );
    // }

    Widget CarouselComponentMaker(String sender, String info, String imageLink){
      return Container(
        width: screenWidth*0.8,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20,top: 15),
                    child: Text(sender,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth*0.05,
                        fontFamily: "Inter"
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20,top: 10),
                    child: Text(info,
                      style: TextStyle(
                          color: Colors.white,
                        fontFamily: "Inter",
                        fontSize: screenWidth*0.035
                      ),
                      overflow: TextOverflow.ellipsis, softWrap: false, maxLines: 3,),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20,top: 15),
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                            "Read More",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: screenWidth*0.036,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: screenWidth*0.22,
              height: screenWidth*0.22,
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imageLink),
                    fit: BoxFit.cover
                ),

              ),
            )
          ],
        ),
      );
    }

    Widget demoCarouselBuilder(){
      return Padding(
        padding: EdgeInsets.only(top: screenWidth*0.09),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CarouselSlider.builder(
              itemCount: 5,
              itemBuilder: (context, index, realIndex){
                return CarouselComponentMaker("Hostel", "ing it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up ", "https://miro.medium.com/max/1400/1*0FqDC0_r1f5xFz3IywLYRA.jpeg");
              },
              options: CarouselOptions(
                  height: screenWidth*0.43,
                  viewportFraction: 1,
                  autoPlay: true,
                  onPageChanged: (index, reason){
                    carouselController.sink.add(index);
                  }
              ),
            ),
            StreamBuilder(
              stream: carouselController.stream,
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  List<Widget> dots = [];
                  for(int i=0;i<5;i++){
                      dots.add(Container(
                        height: screenWidth*0.02,
                        width: screenWidth*0.02,
                        margin: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenWidth*0.02),
                          border: Border.all(color: Theme.of(context).primaryColor),
                          color: i==snapshot.data ? Theme.of(context).primaryColor : Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ));
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: dots,
                    ),
                  );
                }
                return Container();
              },
            )
          ],
        )
      );
    }

    Widget ScrollableListItemMaker(String imageURL, String tileName, String routeID){
      return InkWell(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: screenWidth*0.15,
                width: screenWidth*0.15,
                margin: EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(imageURL),
                    fit: BoxFit.cover
                  )
                ),
              ),
              Container(width: screenWidth*0.2,child: Text(tileName,textAlign: TextAlign.center,style: TextStyle(color: Color(0xFF333333),fontFamily: "Inter",fontSize: screenWidth*0.033),)),
            ],
          ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: screenWidth*0.08,top: screenWidth*0.04),
                width: screenWidth*0.2,
                height: screenWidth*0.08,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(4)
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: screenWidth*0.08,top: screenWidth*0.04),
                width: screenWidth*0.12,
                height: screenWidth*0.12,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(screenWidth*0.06)
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth*0.08,top: screenWidth*0.1),
            child: Text("Hey Kunal!",
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                fontSize: screenWidth*0.06,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth*0.08,top: screenWidth*0.02),
            child: Text("Book your slots beforehand",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth*0.1
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenWidth*0.08),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemSearchScreen()));
                  },
                  child: Container(
                    width: screenWidth*0.7,
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.all(6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(
                              Icons.search,
                            color: Color(0xff4F3A57),
                            size: screenWidth*0.08,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 7),
                          child: Text(
                              "Search Item...",
                            style: TextStyle(
                              fontFamily: "poppins",
                              color: Color(0xff4F3A57),
                              fontSize: screenWidth*0.045
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemSearchScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Image.asset(
                        'assets/images/filter.png',
                      width: screenWidth*0.07,
                    ),
                  ),
                )
              ],
            ),
          ),
          demoCarouselBuilder(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.08,vertical: screenWidth*0.04),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Brahmaputra",
                  style: TextStyle(
                    fontSize: screenWidth*0.06,
                    fontFamily: "Inter",
                    color: Color(0xff717171),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScrollableListItemMaker("assets/images/image.jpg", "Current Allotments", "/currentAllotments"),
                      ScrollableListItemMaker("assets/images/image.jpg", "How to Use Brahmo", "/currentAllotments"),
                      ScrollableListItemMaker("assets/images/image.jpg", "HMC and Developers", "/currentAllotments"),
                      ScrollableListItemMaker("assets/images/image.jpg", "File Complaints", "/currentAllotments")
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      )
    );
  }
}
