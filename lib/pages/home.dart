import 'package:flutter/material.dart';
import 'package:recipora/services/widget_support.dart';
import 'detail_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 18,
              bottom: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ==========================================
                // HEADING
                // ==========================================

                Text(
                  "what would you like\nto cook today?",
                  style: AppWidget.headlineTextStyle(32),
                ),

                const SizedBox(height: 18),

                // ==========================================
                // SEARCH
                // ==========================================

                Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffe3f1ff),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Recipe....",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black54,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ==========================================
                // TODAY RECIPE
                // ==========================================

                Text(
                  "Today Recipe.",
                  style: AppWidget.headlineTextStyle(23),
                ),

                const SizedBox(height: 12),

                // ==========================================
                // RECIPE CARDS
                // ==========================================

                SizedBox(
                  height: 245,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [

                      // ======================================
                      // PIZZA
                      // ======================================

                      _recipeCard(
                        image: "images/pizza.jpg",
                        title: "Cheese Pizza",
                        time: "50 MIN | EASY",
                        width: screenWidth * 0.62,
                      ),

                      const SizedBox(width: 15),

                      // ======================================
                      // BURGER - CLICKABLE
                      // ======================================

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const detail_page(),
                            ),
                          );
                        },
                        child: _recipeCard(
                          image: "images/burger.jpg",
                          title: "Cheese Burger",
                          time: "30 MIN | EASY",
                          width: screenWidth * 0.62,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // ==========================================
                // RECOMMENDED
                // ==========================================

                Text(
                  "Recommended",
                  style: AppWidget.headlineTextStyle(23),
                ),

                const SizedBox(height: 12),

                // ==========================================
                // MUFFIN
                // ==========================================

                _recommendedCard(
                  image: "images/muffin.jpg",
                  title: "Muffin with cocoa cream",
                  country: "Famous: Italian",
                  time: "20 min",
                ),

                const SizedBox(height: 12),

                // ==========================================
                // SANDWICH
                // ==========================================

                _recommendedCard(
                  image: "images/sandwich.jpg",
                  title: "Sandwich with vegetable",
                  country: "Famous: Italian",
                  time: "10 min",
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ======================================================
  // TODAY RECIPE CARD
  // ======================================================

  Widget _recipeCard({
    required String image,
    required String title,
    required String time,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          fit: StackFit.expand,
          children: [

            // Recipe Image
            Image.asset(
              image,
              fit: BoxFit.cover,
            ),

            // Dark Gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color(0xaa000000),
                  ],
                ),
              ),
            ),

            // Recipe Text
            Positioned(
              left: 15,
              right: 15,
              bottom: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    time,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ======================================================
  // RECOMMENDED CARD
  // ======================================================

  Widget _recommendedCard({
    required String image,
    required String title,
    required String country,
    required String time,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [

          // IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              image,
              width: 105,
              height: 105,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 14),

          // INFORMATION
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  country,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [

                    const Icon(
                      Icons.alarm,
                      color: Colors.green,
                      size: 20,
                    ),

                    const SizedBox(width: 5),

                    Text(
                      time,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(width: 15),

                    const Icon(
                      Icons.book,
                      color: Colors.green,
                      size: 20,
                    ),

                    const SizedBox(width: 5),

                    const Text(
                      "EASY",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}