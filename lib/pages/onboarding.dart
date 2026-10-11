import 'package:flutter/material.dart';
import 'package:recipora/services/widget_support.dart';
import 'package:recipora/pages/signup.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // =========================
              // LARGE ONBOARDING IMAGE
              // =========================
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.46,
                child: Image.asset(
                  "images/onboard.png",
                  width: screenWidth,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 10),

              // =========================
              // PREMIUM RECIPES
              // =========================
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "25K+ PREMIUM RECIPES",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // =========================
              // MAIN HEADING
              // =========================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "It's\nCooking Time!",
                  style: AppWidget.headlineTextStyle(48.0),
                ),
              ),

              const SizedBox(height: 25),

              // =========================
              // GET STARTED BUTTON
              // =========================
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      ),
                    );
                  },

                  child: Container(
                    width: screenWidth * 0.78,
                    height: 65,

                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(60),
                    ),

                    child: const Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}