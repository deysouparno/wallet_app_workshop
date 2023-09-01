import 'package:flutter/material.dart';
import 'package:wallet_app_workshop/core/data.dart';
import 'package:wallet_app_workshop/core/styles.dart';
import 'package:wallet_app_workshop/core/widgets/wallet.dart';
import 'package:wallet_app_workshop/home_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late final PageController pageController;
  static const viewportFraction = 0.7;

  @override
  void initState() {
    pageController = PageController(viewportFraction: viewportFraction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final itemWidth = screenSize.width * viewportFraction;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'My Wallet',
                style: TextStyle(fontSize: 35),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Positioned(
                    left: -16,
                    top: -33,
                    bottom: -33,
                    width: 55,
                    child: WalletSide(),
                  ),
                  Positioned.fill(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: onBoardingItems.length,
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          color: AppColors.onBlack,
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: AssetImage(onBoardingItems[index].image),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: -20,
                    top: -30,
                    bottom: -30,
                    width: 55,
                    child: WalletSide(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: (screenSize.width - itemWidth) / 2,
                right: (screenSize.width - itemWidth) / 2,
                top: 40,
                bottom: 50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      onBoardingItems[0].title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      onBoardingItems[0].subtitle,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  PageIndicator(
                    length: onBoardingItems.length,
                    width: itemWidth,
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Get Started!',
                      style: TextStyle(color: AppColors.white),
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
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    this.length = 1,
    this.activeIndex = 0,
    this.width = 50,
  });

  final int length;
  final int activeIndex;
  final double width;

  @override
  Widget build(BuildContext context) {
    final activeWidth = width * 0.5;
    final inActiveWidth =
        (width - activeWidth - (2 * length * 2)) / (length - 1);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Container(
            height: index == activeIndex ? 8 : 5,
            width: index == activeIndex ? activeWidth : inActiveWidth,
            decoration: BoxDecoration(
              color:
                  index == activeIndex ? AppColors.primary : AppColors.onBlack,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}