import 'package:example/flutter/flutter.dart';
import 'package:example/page/page.dart';
import 'package:example/widget/widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:galaxeus_lib_flutter/galaxeus_lib_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey key = GlobalKey();
  int active_index_bottom_bar = 0;
  PageController pageController = PageController();

  List<ScrollController> scrollControllers = List.generate(4, (index) => ScrollController()).toList();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((Duration duration) async {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          width: context.width * 1 / 3,
          showCloseIcon: true,
          content: Text(
            "Slao",
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  getScrollController() {
    scrollControllers[active_index_bottom_bar];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: PageView.builder(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: ConstrainedBox(
              // width: context.width,
              // height: context.height,
              constraints: BoxConstraints(
                minWidth: context.width,
                minHeight: context.height,
              ),
              child: Column(
                children: [
                  SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: context.width,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 250,
                            width: 150,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: ImageFlutter.auto(
                                  image: "assets/user/girl_2.jpg",
                                  default_image: "assets/icons/ghost.png",
                                ).image,
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: MaterialButton(
                              onPressed: () async {
                                if (!context.mounted) {
                                  return;
                                } 
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Color.fromARGB(0, 255, 255, 255),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 0,
                                    content: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          height: 100,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(49, 0, 0, 0),
                                                spreadRadius: 1,
                                                blurRadius: 2,
                                                offset: Offset(0, -0.5), // changes position of shadow
                                              ),
                                              BoxShadow(
                                                color: Color.fromARGB(49, 0, 0, 0),
                                                spreadRadius: 1,
                                                blurRadius: 2,
                                                offset: Offset(0, 0.5), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Hai",
                                                style: context.titleSmall,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    dismissDirection: DismissDirection.none,
                                    onVisible: () {
                                      print("Sa");
                                    },
                                  ),
                                );
                              },
                              minWidth: 0,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [Text("Helo")],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...List.generate(5, (index) {
                    return Container(
                      width: context.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(49, 0, 0, 0),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, -0.5), // changes position of shadow
                          ),
                          BoxShadow(
                            color: Color.fromARGB(49, 0, 0, 0),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 0.5), // changes position of shadow
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.all(10),
                      child: MaterialButton(
                          onPressed: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const ChatPage();
                              },
                            ));
                          },
                          minWidth: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Hai ${index}"),
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: context.width,
                                    maxHeight: context.height * .5,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                      image: ImageFlutter.auto(
                                        image: "assets/user/girl_2.jpg",
                                        default_image: "assets/icons/ghost.png",
                                        fit: BoxFit.fitWidth,
                                      ).image,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    );
                  }).toList(),
                  SizedBox(
                    height: kBottomNavigationBarHeight + kFloatingActionButtonMargin,
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingBarWidget(
        constraints: BoxConstraints(
          minHeight: 0,
          minWidth: context.width,
          maxHeight: 35,
          maxWidth: context.width,
        ),
        activeIndex: active_index_bottom_bar,
        activeContainer: FloatingBarWidgetContainerData(
          decoration: BoxDecoration(
            color: Colors.red,
          ),
        ),
        inActiveContainer: FloatingBarWidgetContainerData(),
        bottomBars: [
          FloatingBarWidgetData(
            icon: Icon(Icons.home),
            text: Text(
              "Home",
              overflow: TextOverflow.ellipsis,
            ),
          ),
          FloatingBarWidgetData(
            icon: Icon(Icons.home),
            text: Text(
              "Fyp",
              overflow: TextOverflow.ellipsis,
            ),
          ),
          FloatingBarWidgetData(
            icon: Icon(Icons.home),
            text: Text(
              "Notif",
              overflow: TextOverflow.ellipsis,
            ),
          ),
          FloatingBarWidgetData(
            icon: Icon(Icons.home),
            text: Text(
              "Me",
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
        onTap: (index, context) {
          setState(() {
            pageController.jumpToPage(index);
            active_index_bottom_bar = index;
          });
        },
      ),
    );
  }
}
