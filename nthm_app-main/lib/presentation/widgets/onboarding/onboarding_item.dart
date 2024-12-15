import 'package:flutter/material.dart';
import 'package:nthm_app/data/models/onboarding_data.dart';
import 'package:nthm_app/utils/responsive.dart';

class OnBoardingItem extends StatelessWidget {
  final BoardingModel model;

  const OnBoardingItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(model.image),
        ),
        SizedBox(height: responsive.getHeight(5)),
        Text(
          model.title,
          style: TextStyle(
            fontSize: responsive.getFontSize(24),
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: responsive.getHeight(2.5)),
        Text(
          model.body,
          style: TextStyle(
            fontSize: responsive.getFontSize(16),
          ),
        ),
        SizedBox(height: responsive.getHeight(5)),
      ],
    );
  }
}