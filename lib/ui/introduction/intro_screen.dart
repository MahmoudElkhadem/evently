import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/introduction/intro_model.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_route.dart';
import 'package:evently/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<IntroScreen> {
  final PageController _pageController = PageController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    final pages = getPages(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(
              horizontal: width*0.04,
              vertical: height*0.02
          ),
          child: Column(
            children: [
              Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentIndex != 0 ?
                      IconButton(onPressed: (){
                        _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut
                        );
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded))
                  :SizedBox(width: 50),
                  Image.asset(
                    AppAssets.eventlyLogoLight,
                  ),
                  ElevatedButton(
                    onPressed: () {
                        Navigator.pushNamed(context, AppRoute.loginScreen);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.inputsLightMode,
                        foregroundColor: AppColor.mainLightMode,
                    ),
                    child: Text(
                        AppLocalizations.of(context)!.skip,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Image.asset(
                          pages[index].image,
                          fit: BoxFit.fill,
                        ),

                        const SizedBox(height: 10),

                        SmoothPageIndicator(
                          controller: _pageController,
                          count: pages.length,
                          effect:  ExpandingDotsEffect(
                            dotColor: Theme.of(context).cardColor,
                            activeDotColor: Theme.of(context).primaryColor,
                            dotHeight: 10,
                            dotWidth: 12,
                            expansionFactor: 2
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          pages[index].title,
                          style: Theme.of(context).textTheme.headlineLarge
                        ),

                        const SizedBox(height: 10),

                        Text(
                          pages[index].description,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (currentIndex < pages.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pushNamed(context, AppRoute.loginScreen);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: AppColor.inputsLightMode,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    ),
                  ),
                  child: Text(
                    currentIndex == pages.length - 1
                        ? AppLocalizations.of(context)!.getStarted
                        : AppLocalizations.of(context)!.next,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}