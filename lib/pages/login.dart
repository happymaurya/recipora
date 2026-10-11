import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipora/pages/main_navigation.dart';
import 'package:recipora/pages/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
  }

  // =====================================================
  // LOGIN
  // =====================================================

  Future<void> login() async {
    FocusScope.of(context).unfocus();

    final email = mailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty) {
      _showMessage(
        'Please enter your email',
        Colors.orange,
      );
      return;
    }

    if (password.isEmpty) {
      _showMessage(
        'Please enter your password',
        Colors.orange,
      );
      return;
    }

    if (!email.contains('@')) {
      _showMessage(
        'Please enter a valid email',
        Colors.orange,
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final UserCredential credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint('================================');
      debugPrint('LOGIN SUCCESS');
      debugPrint('UID: ${credential.user?.uid}');
      debugPrint('EMAIL: ${credential.user?.email}');
      debugPrint('================================');

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      _showMessage(
        'Login Successful',
        Colors.green,
      );

      await Future.delayed(
        const Duration(milliseconds: 500),
      );

      if (!mounted) return;

      // =================================================
      // IMPORTANT:
      // After login open MainNavigation, NOT Home
      // =================================================

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainNavigation(),
        ),
            (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('================================');
      debugPrint('FIREBASE LOGIN ERROR');
      debugPrint('CODE: ${e.code}');
      debugPrint('MESSAGE: ${e.message}');
      debugPrint('================================');

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      String message;

      switch (e.code) {
        case 'invalid-credential':
          message = 'Incorrect email or password.';
          break;

        case 'wrong-password':
          message = 'Incorrect password.';
          break;

        case 'user-not-found':
          message = 'No account found with this email.';
          break;

        case 'invalid-email':
          message = 'Please enter a valid email.';
          break;

        case 'user-disabled':
          message = 'This account has been disabled.';
          break;

        case 'too-many-requests':
          message = 'Too many attempts. Please try again later.';
          break;

        case 'network-request-failed':
          message = 'No internet connection.';
          break;

        case 'operation-not-allowed':
          message =
          'Email/Password login is not enabled in Firebase.';
          break;

        case 'invalid-api-key':
          message = 'Firebase configuration is incorrect.';
          break;

        case 'app-not-authorized':
          message = 'This app is not authorized in Firebase.';
          break;

        default:
          message = 'Firebase error: ${e.code}';
      }

      _showMessage(
        message,
        Colors.redAccent,
      );
    } catch (e) {
      debugPrint('================================');
      debugPrint('GENERAL LOGIN ERROR');
      debugPrint('$e');
      debugPrint('================================');

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      _showMessage(
        'Error: $e',
        Colors.redAccent,
      );
    }
  }

  // =====================================================
  // FORGOT PASSWORD
  // =====================================================

  Future<void> forgotPassword() async {
    final email = mailController.text.trim();

    if (email.isEmpty) {
      _showMessage(
        'Enter your email first',
        Colors.orange,
      );
      return;
    }

    if (!email.contains('@')) {
      _showMessage(
        'Please enter a valid email',
        Colors.orange,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );

      if (!mounted) return;

      _showMessage(
        'Password reset email sent',
        Colors.green,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(
        'Password reset error: ${e.code} - ${e.message}',
      );

      if (!mounted) return;

      String message;

      switch (e.code) {
        case 'user-not-found':
          message = 'No account found with this email.';
          break;

        case 'invalid-email':
          message = 'Please enter a valid email.';
          break;

        case 'network-request-failed':
          message = 'Check your internet connection.';
          break;

        default:
          message = 'Firebase error: ${e.code}';
      }

      _showMessage(
        message,
        Colors.redAccent,
      );
    } catch (e) {
      if (!mounted) return;

      _showMessage(
        'Error: $e',
        Colors.redAccent,
      );
    }
  }

  // =====================================================
  // MESSAGE
  // =====================================================

  void _showMessage(
      String message,
      Color color,
      ) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.expand,
          children: [

            // BACKGROUND
            Positioned.fill(
              child: Image.asset(
                'images/front_page.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),

            // DARK OVERLAY
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.38),
              ),
            ),

            // CONTENT
            SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  left: 28,
                  right: 28,
                  top: size.height * 0.08,
                  bottom: 45,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // TITLE
                    const Text(
                      'Welcome\nBack!',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.15,
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.10,
                    ),

                    // EMAIL TITLE
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // EMAIL
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color:
                            Colors.black.withValues(alpha: 0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: mailController,
                        keyboardType:
                        TextInputType.emailAddress,
                        textInputAction:
                        TextInputAction.next,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color(0xff994c7a),
                            size: 22,
                          ),
                          border: InputBorder.none,
                          contentPadding:
                          const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 17,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // PASSWORD TITLE
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // PASSWORD
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color:
                            Colors.black.withValues(alpha: 0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        keyboardType:
                        TextInputType.visiblePassword,
                        textInputAction:
                        TextInputAction.done,
                        onSubmitted: (_) {
                          if (!isLoading) {
                            login();
                          }
                        },
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color(0xff994c7a),
                            size: 22,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePassword =
                                !obscurePassword;
                              });
                            },
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color:
                              const Color(0xff994c7a),
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding:
                          const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 17,
                          ),
                        ),
                      ),
                    ),

                    // FORGOT PASSWORD
                    const SizedBox(height: 12),

                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: isLoading
                            ? null
                            : forgotPassword,
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.07,
                    ),

                    // LOGIN BUTTON
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [

                        const Padding(
                          padding:
                          EdgeInsets.only(left: 28),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: isLoading ? null : login,
                          child: Container(
                            width: 74,
                            height: 74,
                            decoration: BoxDecoration(
                              color:
                              const Color(0xff994c7a),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withValues(alpha: 0.25),
                                  blurRadius: 12,
                                  offset:
                                  const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Center(
                              child: isLoading
                                  ? const SizedBox(
                                width: 28,
                                height: 28,
                                child:
                                CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor:
                                  AlwaysStoppedAnimation<
                                      Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                                  : const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 34,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 55),

                    // SIGN UP
                    Center(
                      child: GestureDetector(
                        onTap: isLoading
                            ? null
                            : () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const SignUp(),
                            ),
                          );
                        },
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text:
                                "Don't have an account? ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight:
                                  FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: Color(0xffffd6ed),
                                  fontSize: 14,
                                  fontWeight:
                                  FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}