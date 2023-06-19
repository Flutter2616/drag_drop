import 'package:drag_drop/controller/drag_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Dragscreen extends StatefulWidget {
  const Dragscreen({super.key});

  @override
  State<Dragscreen> createState() => _DragscreenState();
}

class _DragscreenState extends State<Dragscreen> {
  Dragcontroller controller = Get.put(Dragcontroller());

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(onTap: () {
                  controller.elephant.value=false;
                  controller.house.value=false;
                  controller.fox.value=false;
                  controller.cat.value=false;
                  controller.ball.value=false;
                  controller.apple.value=false;
                  controller.score.value=0;
                },child: Icon(Icons.refresh,color: Colors.white,size: 25)),
              )
            ],
            centerTitle: false,
            title: Text("Drag and Drop game",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            elevation: 0,
            backgroundColor: Colors.deepPurple.shade500),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => Text("Score: ${controller.score}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 25),
                        dragtarget(
                            "Apple", "🍎", controller.apple, controller.score),
                        SizedBox(height: 25),
                        dragtarget(
                            "Fox", "🦊", controller.fox, controller.score),
                        SizedBox(height: 25),
                        dragtarget(
                            "Cat", "🐱", controller.cat, controller.score),
                        SizedBox(height: 25),
                        dragtarget(
                            "Ball", "⚽", controller.ball, controller.score),
                        SizedBox(height: 25),
                        dragtarget(
                            "House", "🏘", controller.house, controller.score),
                        SizedBox(height: 25),
                        dragtarget("Elephant", "🐘", controller.elephant,
                            controller.score),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 25),
                        dragitem("Cat", "🐱", controller.cat),
                        SizedBox(height: 25),
                        dragitem("Ball", "⚽", controller.ball),
                        SizedBox(height: 25),
                        dragitem("Elephant", "🐘", controller.elephant),
                        SizedBox(height: 25),
                        dragitem("House", "🏘", controller.house),
                        SizedBox(height: 25),
                        dragitem("Fox", "🦊", controller.fox),
                        SizedBox(height: 25),
                        dragitem("Apple", "🍎", controller.apple),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dragtarget(
    String title,
    String tag,
    RxBool ball,
    RxInt score,
  ) {
    return DragTarget(
      onWillAccept: (data) {
        return data == '$title';
      },
      onAccept: (data) {
        ball.value = true;
        score.value++;
      },
      builder: (context, candidateData, rejectedData) => ball.value
          ? Container(
              height: 60,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.deepPurple.shade500,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("$title",
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                  Text("$tag",
                      style: TextStyle(
                        fontSize: 50,
                      )),
                ],
              ),
            )
          : Container(
              height: 60,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.deepPurple.shade500,
                  borderRadius: BorderRadius.circular(20)),
              child: Text("$title",
                  style: TextStyle(fontSize: 15, color: Colors.white)),
            ),
    );
  }

  Widget dragitem(
    String name,
    String tag,
    RxBool cat,
  ) {
    return Obx(
      () => Draggable(
          child: cat.value
              ? Container()
              : Text("$tag", style: TextStyle(fontSize: 50)),
          childWhenDragging: Container(),
          data: name,
          feedback: Text("$tag", style: TextStyle(fontSize: 50))),
    );
  }
}
