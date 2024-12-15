import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nthm_app/config/app_routes.dart';
import 'package:nthm_app/data/models/onboarding_data.dart';
import 'package:nthm_app/generated/assets.dart';
import 'package:nthm_app/logic/cubit/onboarding/onboarding_cubit.dart';
import 'package:nthm_app/presentation/widgets/onboarding/onboarding_item.dart';
import 'package:nthm_app/utils/responsive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  final PageController boardController = PageController();

  final List<BoardingModel> boarding = [
    BoardingModel(
      image: Assets.imagesOnboarding1,
      title: 'Welcome to NTHM',
      body: 'Your Health gateway to Explore medicine info, set dose reminders, and manage health records effortlessly',
    ),
    BoardingModel(
      image: Assets.imagesOnboarding2,
      title: 'Connect with Healthcare Providers',
      body: 'Easily find and connect with local healthcare providers. Chat with doctors, get advice, and stay informed',
    ),
    BoardingModel(
      image: Assets.imagesOnboarding3,
      title: 'Manage Your Health Effortlessly',
      body: 'Keep track of your medical history, manage privacy settings, and receive personalized health tips and reminders.',
    ),
  ];

  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return BlocProvider(
      create: (_) => OnBoardingCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            // Gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF368fd2),
                    Color(0xFFFFFFFF),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<OnBoardingCubit, int>(
                        builder: (context, currentPage) {
                          return PageView.builder(
                            controller: boardController,
                            onPageChanged: (index) {
                              BlocProvider.of<OnBoardingCubit>(context)
                                  .changePage(index);
                            },
                            itemCount: boarding.length,
                            itemBuilder: (context, index) =>
                                OnBoardingItem(model: boarding[index]),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: responsive.getHeight(5)),
                    Row(
                      children: [
                        SmoothPageIndicator(
                          controller: boardController,
                          effect: ExpandingDotsEffect(
                            dotColor: Colors.grey,
                            activeDotColor: const Color(0xFF368fd2),
                            dotHeight: responsive.getHeight(1.5),
                            expansionFactor: 4,
                            dotWidth: responsive.getWidth(2.5),
                            spacing: responsive.getWidth(1),
                          ),
                          count: boarding.length,
                        ),
                        const Spacer(),
                        BlocBuilder<OnBoardingCubit, int>(
                          builder: (context, currentPage) {
                            return FloatingActionButton(
                              backgroundColor: const Color(0xFF368fd2),
                              onPressed: () {
                                if (currentPage == boarding.length - 1) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.welcome,
                                  );
                                } else {
                                  boardController.nextPage(
                                    duration: const Duration(milliseconds: 750),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                  );
                                }
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: responsive.getHeight(6),
              right: responsive.getWidth(1),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.welcome);
                },
                child: Text(
                  'SKIP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: responsive.getFontSize(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
