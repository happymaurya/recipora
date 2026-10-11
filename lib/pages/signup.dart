import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:recipora/pages/home.dart';
import 'package:recipora/pages/login.dart';
import 'package:recipora/services/database.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // =========================================================
  // CONTROLLERS
  // =========================================================

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController mailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  // =========================================================
  // VARIABLES
  // =========================================================

  bool isLoading = false;
  bool obscurePassword = true;

  // =========================================================
  // REGISTRATION
  // =========================================================

  Future<void> registration() async {
    FocusScope.of(context).unfocus();

    // Check empty fields
    if (nameController.text.trim().isEmpty ||
        mailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      showMessage(
        "Please fill all fields",
        Colors.orange,
      );

      return;
    }

    // Check password
    if (passwordController.text.trim().length < 6) {
      showMessage(
        "Password must be at least 6 characters",
        Colors.orange,
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // =======================================================
      // CREATE FIREBASE ACCOUNT
      // =======================================================

      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // =======================================================
      // CREATE USER ID
      // =======================================================

      String ID = randomAlphaNumeric(10);

      // =======================================================
      // USER INFORMATION
      // =======================================================

      Map<String, dynamic> userInfoMap = {
        "Name": nameController.text.trim(),
        "Email": mailController.text.trim(),
        "Id": ID,
        "FirebaseUid": userCredential.user?.uid,
      };

      // =======================================================
      // SAVE TO FIRESTORE
      // =======================================================

      await DatabaseMethod().addUserInfo(
        userInfoMap,
        ID,
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      // =======================================================
      // SUCCESS
      // =======================================================

      showMessage(
        "Registration Successful",
        Colors.green,
      );

      // =======================================================
      // GO HOME
      // =======================================================

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    }

    // =========================================================
    // FIREBASE ERROR
    // =========================================================

    on FirebaseAuthException catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      String message = "Registration failed";

      if (e.code == "weak-password") {
        message = "Password is too weak";
      } else if (e.code == "email-already-in-use") {
        message = "Email is already registered";
      } else if (e.code == "invalid-email") {
        message = "Please enter a valid email";
      } else if (e.code == "operation-not-allowed") {
        message = "Email/password authentication is disabled";
      } else if (e.code == "network-request-failed") {
        message = "Check your internet connection";
      } else if (e.message != null) {
        message = e.message!;
      }

      showMessage(
        message,
        Colors.red,
      );
    }

    // =========================================================
    // OTHER ERROR
    // =========================================================

    catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      showMessage(
        "Error: $e",
        Colors.red,
      );
    }
  }

  // =========================================================
  // SNACKBAR MESSAGE
  // =========================================================

  void showMessage(
      String message,
      Color color,
      ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // INPUT FIELD
  // =========================================================

  Widget inputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 13,
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xff994c7a),
            size: 20,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    nameController.dispose();
    mailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffead9),

      resizeToAvoidBottomInset: true,

      body: Stack(
        children: [

          // =====================================================
          // FULL SCREEN BACKGROUND IMAGE
          // =====================================================

          Positioned.fill(
            child: Image.asset(
              "images/front_page.jpg",

              fit: BoxFit.cover,

              alignment: Alignment.center,

              // If image fails, show a clean background
              errorBuilder: (
                  BuildContext context,
                  Object error,
                  StackTrace? stackTrace,
                  ) {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xffffead9),
                        Color(0xffffd5b8),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // =====================================================
          // SOFT OVERLAY
          // =====================================================

          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.12),
            ),
          ),

          // =====================================================
          // CENTER CONTENT
          // =====================================================

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),

                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 20,
                ),

                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 420,
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [

                      // =================================================
                      // TITLE
                      // =================================================

                      const Text(
                        "Create Account!",
                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: Color(0xff4d2638),
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 7),

                      const Text(
                        "Create your account to discover\n"
                            "delicious recipes",
                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: Color(0xff684b52),
                          fontSize: 13,
                          height: 1.35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // =================================================
                      // SIGNUP CARD
                      // =================================================

                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.all(20),

                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),

                          borderRadius:
                          BorderRadius.circular(26),

                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.18),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.stretch,

                          children: [

                            // =========================================
                            // NAME
                            // =========================================

                            const Text(
                              "Name",
                              style: TextStyle(
                                color: Color(0xff4d3440),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 7),

                            inputField(
                              controller: nameController,
                              hintText: "Enter your name",
                              icon: Icons.person_outline,
                              keyboardType:
                              TextInputType.name,
                            ),

                            const SizedBox(height: 15),

                            // =========================================
                            // EMAIL
                            // =========================================

                            const Text(
                              "Email",
                              style: TextStyle(
                                color: Color(0xff4d3440),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 7),

                            inputField(
                              controller: mailController,
                              hintText: "Enter your email",
                              icon: Icons.email_outlined,
                              keyboardType:
                              TextInputType.emailAddress,
                            ),

                            const SizedBox(height: 15),

                            // =========================================
                            // PASSWORD
                            // =========================================

                            const Text(
                              "Password",
                              style: TextStyle(
                                color: Color(0xff4d3440),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 7),

                            inputField(
                              controller:
                              passwordController,
                              hintText: "Create a password",
                              icon: Icons.lock_outline,
                              obscureText:
                              obscurePassword,
                              keyboardType:
                              TextInputType.visiblePassword,

                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscurePassword =
                                    !obscurePassword;
                                  });
                                },

                                icon: Icon(
                                  obscurePassword
                                      ? Icons
                                      .visibility_off_outlined
                                      : Icons
                                      .visibility_outlined,

                                  color:
                                  const Color(0xff994c7a),

                                  size: 19,
                                ),
                              ),
                            ),

                            const SizedBox(height: 23),

                            // =========================================
                            // CREATE ACCOUNT BUTTON
                            // =========================================

                            SizedBox(
                              height: 55,

                              child: ElevatedButton(
                                onPressed:
                                isLoading
                                    ? null
                                    : registration,

                                style:
                                ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color(
                                      0xff994c7a),

                                  disabledBackgroundColor:
                                  const Color(
                                      0xff994c7a)
                                      .withOpacity(0.55),

                                  elevation: 4,

                                  shadowColor:
                                  const Color(
                                      0xff994c7a)
                                      .withOpacity(0.35),

                                  shape:
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        16),
                                  ),
                                ),

                                child: isLoading
                                    ? const SizedBox(
                                  height: 23,
                                  width: 23,
                                  child:
                                  CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor:
                                    AlwaysStoppedAnimation<
                                        Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                                    : const Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,

                                  children: [

                                    Text(
                                      "Create Account",
                                      style: TextStyle(
                                        color:
                                        Colors.white,
                                        fontSize: 15,
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                      ),
                                    ),

                                    SizedBox(width: 8),

                                    Icon(
                                      Icons
                                          .arrow_forward_rounded,
                                      color:
                                      Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      // =================================================
                      // LOGIN BUTTON
                      // =================================================

                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const Login(),
                            ),
                          );
                        },

                        child: Container(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 10,
                          ),

                          decoration: BoxDecoration(
                            color:
                            Colors.white.withOpacity(0.88),

                            borderRadius:
                            BorderRadius.circular(30),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.08),

                                blurRadius: 8,

                                offset:
                                const Offset(0, 3),
                              ),
                            ],
                          ),

                          child: RichText(
                            textAlign: TextAlign.center,

                            text: const TextSpan(
                              children: [

                                TextSpan(
                                  text:
                                  "Already have an account? ",

                                  style: TextStyle(
                                    color:
                                    Color(0xff5d464c),
                                    fontSize: 12,
                                    fontWeight:
                                    FontWeight.w500,
                                  ),
                                ),

                                TextSpan(
                                  text: "Log In",

                                  style: TextStyle(
                                    color:
                                    Color(0xff994c7a),
                                    fontSize: 12,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}