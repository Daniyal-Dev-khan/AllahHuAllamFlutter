import 'package:allah_ho_allam_flutter/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  final List<Map<String, String>> contents = [
    {
      "title": "Welcome to ALLAHuALAM",
      "image": "assets/images/ic_onboarding_prayers.png",
      "desc": "We are very excited to have you in our community",
    },
    {
      "title": "Reading the Quran",
      "image": "assets/images/ic_onboarding_quran.png",
      "desc": "Read, and your Lord is the Most Generous",
    },
    {
      "title": "Islamic Chat Bot",
      "image": "assets/images/ic_onboarding_quran.png",
      "desc": "Praise the name of your Lord, The most high",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_primary.png"),
            // your background image
            fit: BoxFit.cover, // cover = fill entire screen
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SvgPicture.asset(
                  "assets/images/text_allah_ho_allam.svg",
                  height: 25,
                ),
              ),
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemCount: contents.length,
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Expanded(child: Image.asset(contents[i]["image"]!)),
                        const SizedBox(height: 20),
                        Text(
                          contents[i]["title"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 24,
                            // fontWeight: FontWeight.bold,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700, // Bold
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          contents[i]["desc"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w400, // Regular
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        contents.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 10,
                          width: _currentPage == index ? 20 : 10,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? AppColors.green
                                : AppColors.textPrimary,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    // buttons
                    _currentPage == contents.length - 1
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.green,
                              // minimumSize: const Size.fromHeight(50),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>  LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "START",
                              style: TextStyle(color: AppColors.background),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () =>
                                    _controller.jumpToPage(contents.length - 1),
                                child: const Text(
                                  "SKIP",
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w400, // Regular
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => _controller.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                ),
                                child: const Text(
                                  "NEXT",
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w400, // Regular
                                  ),
                                ),
                              ),
                              // ElevatedButton(
                              //   onPressed: () => _controller.nextPage(
                              //     duration: const Duration(milliseconds: 200),
                              //     curve: Curves.easeIn,
                              //   ),
                              //   child: const Text("NEXT"),
                              // ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
