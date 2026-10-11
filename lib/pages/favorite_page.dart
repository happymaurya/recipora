import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final List<Map<String, dynamic>> foodAlarms = [
    {
      'name': 'Cheese Burger',
      'time': '8:00 PM',
      'type': 'Daily',
      'days': <String>[],
    },
    {
      'name': 'Pizza',
      'time': '7:30 PM',
      'type': 'Weekly',
      'days': ['Mon', 'Wed', 'Fri'],
    },
  ];

  final List<Map<String, dynamic>> favoriteRecipes = [
    {
      'name': 'Chicken Biryani',
      'icon': Icons.restaurant,
    },
    {
      'name': 'Healthy Salad',
      'icon': Icons.eco,
    },
    {
      'name': 'Chocolate Cake',
      'icon': Icons.cake,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: const Color(0xffff7043),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.add_alarm,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =========================
            // FOOD ALARMS
            // =========================

            Row(
              children: [
                const Icon(
                  Icons.alarm,
                  color: Color(0xffff7043),
                  size: 25,
                ),
                const SizedBox(width: 8),
                const Text(
                  'FOOD ALARMS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${foodAlarms.length}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            if (foodAlarms.isEmpty)
              _emptyMessage(
                Icons.alarm_off,
                'No food alarms',
              )
            else
              ...List.generate(
                foodAlarms.length,
                    (index) => _alarmCard(index),
              ),

            const SizedBox(height: 25),

            Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xffe5e5e5),
            ),

            const SizedBox(height: 25),

            // =========================
            // MY FAVORITES
            // =========================

            Row(
              children: [
                const Icon(
                  Icons.favorite,
                  color: Color(0xffff7043),
                  size: 25,
                ),
                const SizedBox(width: 8),
                const Text(
                  'MY FAVORITES',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${favoriteRecipes.length}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            if (favoriteRecipes.isEmpty)
              _emptyMessage(
                Icons.favorite_border,
                'No favorite recipes',
              )
            else
              ...List.generate(
                favoriteRecipes.length,
                    (index) => _favoriteCard(index),
              ),
          ],
        ),
      ),
    );
  }

  // =========================
  // ALARM CARD
  // =========================

  Widget _alarmCard(int index) {
    final alarm = foodAlarms[index];

    final String name = alarm['name'];
    final String time = alarm['time'];
    final String type = alarm['type'];

    final List<String> days =
    List<String>.from(alarm['days'] ?? []);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xfffff7f3),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xffffdfd2),
        ),
      ),
      child: Row(
        children: [

          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.restaurant,
              color: Color(0xffff7043),
              size: 30,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 17,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                if (type == 'Weekly' &&
                    days.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    days.join('   '),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffff7043),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              type,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // FAVORITE CARD
  // =========================

  Widget _favoriteCard(int index) {
    final recipe = favoriteRecipes[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
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

          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: const Color(0xfffff1eb),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              recipe['icon'],
              color: const Color(0xffff7043),
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              recipe['name'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const Icon(
            Icons.favorite,
            color: Color(0xffff7043),
            size: 25,
          ),
        ],
      ),
    );
  }

  // =========================
  // EMPTY MESSAGE
  // =========================

  Widget _emptyMessage(
      IconData icon,
      String text,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}