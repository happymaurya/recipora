import 'package:flutter/material.dart';
import 'package:recipora/services/widget_support.dart';
import 'package:recipora/services/alarm_service.dart';

class detail_page extends StatefulWidget {
  const detail_page({super.key});

  @override
  State<detail_page> createState() => _detail_pageState();
}

class _detail_pageState extends State<detail_page> {
  String? selectedAlarmTime;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // ==========================================
            // BURGER IMAGE
            // ==========================================

            Image.asset(
              "images/burger.jpg",
              height: screenHeight / 2.5,
              width: screenWidth,
              fit: BoxFit.cover,
            ),

            // ==========================================
            // WHITE CONTENT
            // ==========================================
            Container(
              margin: EdgeInsets.only(top: screenHeight / 3),
              width: screenWidth,
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  // ======================================
                  // TITLE
                  // ======================================
                  Text(
                    "Cheese Burger",
                    style: AppWidget.headlineTextStyle(32.0),
                  ),

                  const SizedBox(height: 20),

                  // ======================================
                  // INFO BOXES
                  // ======================================
                  Row(
                    children: [
                      // ==================================
                      // ALARM / TIME
                      // ==================================

                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _showAlarmPicker(context);
                          },
                          child: Container(
                            height: 130,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: const Color(0xffddf1e6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "images/alarm.png",
                                  height: 45,
                                  width: 45,
                                  fit: BoxFit.contain,
                                  color: const Color(0xff5ab38a),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  selectedAlarmTime ?? "SET ALARM",
                                  style: const TextStyle(
                                    color: Color(0xff5ab38a),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // ==================================
                      // DIFFICULTY
                      // ==================================
                      Expanded(
                        child: Container(
                          height: 130,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color(0xfffdf0db),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/smiley.png",
                                height: 45,
                                width: 45,
                                fit: BoxFit.contain,
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                "MEDIUM",
                                style: TextStyle(
                                  color: Color(0xffe4b46b),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // ==================================
                      // CALORIES
                      // ==================================
                      Expanded(
                        child: Container(
                          height: 130,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color(0xffe7eefa),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/fire.png",
                                height: 45,
                                width: 45,
                                fit: BoxFit.contain,
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                "300 Cal",
                                style: TextStyle(
                                  color: Color(0xff7b1dcc),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // ======================================
                  // INGREDIENTS
                  // ======================================
                  Text("Ingredients", style: AppWidget.headlineTextStyle(25.0)),

                  const SizedBox(height: 12),

                  _ingredient("1) 4 Big white Seeded Buns"),
                  _ingredient("2) Unsalted Butter"),
                  _ingredient("3) American Cheese"),
                  _ingredient("4) 1 Sweet Onion"),

                  const SizedBox(height: 25),

                  // ======================================
                  // DIRECTIONS
                  // ======================================
                  Text("Directions", style: AppWidget.headlineTextStyle(25.0)),

                  const SizedBox(height: 10),

                  const Text(
                    "A juicy and delicious burger made with a "
                    "crispy golden patty, fresh lettuce, crunchy "
                    "vegetables, creamy sauce, and a generous "
                    "layer of melted cheese, all served inside "
                    "a soft toasted burger bun. Perfectly "
                    "balanced, cheesy, flavorful, and "
                    "satisfying for a quick and tasty meal.",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),

            // ==========================================
            // BACK BUTTON
            // ==========================================
            Positioned(
              top: 50,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x25000000),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // ALARM TIME PICKER
  // ==========================================

  Future<void> _showAlarmPicker(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) {
      return;
    }

    final now = DateTime.now();

    DateTime alarmTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    // If selected time has already passed today,
    // schedule it for tomorrow.
    if (alarmTime.isBefore(now)) {
      alarmTime = alarmTime.add(const Duration(days: 1));
    }

    final int alarmId = DateTime.now().millisecondsSinceEpoch.remainder(
      2147483647,
    );

    await AlarmService.setAlarm(
      id: alarmId,
      recipeName: "Cheese Burger",
      dateTime: alarmTime,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      selectedAlarmTime = time.format(context);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("🍔 Cheese Burger alarm set for ${time.format(context)}"),
        backgroundColor: const Color(0xff5ab38a),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ==========================================
  // INGREDIENT WIDGET
  // ==========================================

  Widget _ingredient(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
