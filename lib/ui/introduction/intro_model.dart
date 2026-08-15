import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String description;

  OnBoardingModel({
  required this.image,
  required this.title,
  required this.description,
  });
}

List<OnBoardingModel> getPages(BuildContext context) {
  return [
    OnBoardingModel(
      image: AppAssets.intro2,
      title: AppLocalizations.of(context)!.introTitle1,
      description: AppLocalizations.of(context)!.introCaption1,
    ),
    OnBoardingModel(
      image: AppAssets.intro3,
      title: AppLocalizations.of(context)!.introTitle2,
      description: AppLocalizations.of(context)!.introCaption2,
    ),
    OnBoardingModel(
      image: AppAssets.intro4,
      title: AppLocalizations.of(context)!.introTitle3,
      description: AppLocalizations.of(context)!.introCaption3,
    ),
  ];
}