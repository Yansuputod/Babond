// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:babond/core/constants/app_colors.dart';

class OnBoardingPage extends StatelessWidget {
  final VoidCallback onFinish;
  const OnBoardingPage({super.key, required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: const Color.fromRGBO(255, 253, 235, 1),
      pages: [
        PageViewModel(
          title: '',
          body: '',
          image: _buildFullImage('assets/landing/land1.jpg'),
          decoration: _pageDecoration(),
        ),
        PageViewModel(
          title: '',
          body: '',
          image: _buildFullImage('assets/landing/land2.jpg'),
          decoration: _pageDecoration(),
        ),
        PageViewModel(
          title: '',
          body: '',
          image: _buildFullImage('assets/landing/land3.jpg', withButton: true),
          decoration: _pageDecoration(),
        ),
      ],
      onDone: onFinish,
      showSkipButton: true,
      skip: Text("Skip", style: TextStyle(color: AppColors.pinkDark, fontSize: 18, fontWeight: FontWeight.w500)),
      next: Icon(Icons.arrow_forward, color: AppColors.pinkDark, size: 28),
      done: Text("Let's Go!", style: TextStyle(color: AppColors.pinkDark, fontSize: 18, fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
        activeColor: AppColors.pinkDark,
        color: AppColors.pinkDark.withOpacity(0.3),
        size: const Size(12, 12),
        activeSize: const Size(16, 16),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildFullImage(String assetPath, {bool withButton = false}) {
    if (withButton) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Image.asset(
              assetPath,
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.pinkDark,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              onPressed: onFinish,
              child: const Text(
                'Let\'s Go!',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          )
        ],
      );
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: Image.asset(
            assetPath,
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      );
    }
  }

  PageDecoration _pageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(),
      bodyTextStyle: TextStyle(),
      imagePadding: EdgeInsets.zero,
      contentMargin: EdgeInsets.zero,
      pageColor: Colors.transparent,
      bodyFlex: 0,
      imageFlex: 1,
      fullScreen: true,
    );
  }
}
