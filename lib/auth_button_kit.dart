import 'package:auth_button_kit/enum.dart';
import 'package:flutter/material.dart';

export 'enum.dart';

class AuthButton extends StatelessWidget {
  /// A single authentication button.
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.brand,
    this.text = 'Continue with {brand}',
    this.textCentering = Centering.relative,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.shape,
    this.fontFamily,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 18,
    this.letterSpacing,
    this.showLoader = false,
    this.loaderColor = Colors.black,
    this.splashEffect = true,
    this.customImage,
    this.imageHeight = 21,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
  });

  /// The function called when the button is pressed, the brand (ex: Method.google) is passed as a parameter
  final Function(Method) onPressed;

  /// The brand of the button (ex: Method.google)
  final Method brand;

  /// The text of the button, you can use {brand} to display the brand name
  final String text;

  /// The layout of the text for different visual choices
  final Centering textCentering;

  /// The text color of the button, adapts to contrast with background by default
  final Color textColor;

  /// The background color of the button
  final Color backgroundColor;

  /// The button's shape with options to specify borders (color, width) and corner radius
  final OutlinedBorder? shape;

  /// The font family of the button
  final String? fontFamily;

  /// The font weight of the button
  final FontWeight? fontWeight;

  /// The font size of the button text
  final double? fontSize;

  /// The letter spacing of the button text
  final double? letterSpacing;

  /// Show a loader when you want
  final bool showLoader;

  /// The color of the loader, adapts to contrast with background by default
  final Color loaderColor;

  /// Show a splash effect when the button is pressed, does not work with a dark background
  final bool splashEffect;

  /// Change the default logo of the button, works only with AuthButton class and Method.custom
  final Image? customImage;

  /// The height of the image associated with the button
  final double imageHeight;

  /// Manage the space around the button
  final EdgeInsetsGeometry padding;

  String getContrastColor(Color color) {
    final r = (color.r * 255.0).round().clamp(0, 255);
    final g = (color.g * 255.0).round().clamp(0, 255);
    final b = (color.b * 255.0).round().clamp(0, 255);
    return r * 0.299 + g * 0.587 + b * 0.114 > 186 ? "dark" : "light";
  }

  @override
  Widget build(BuildContext context) {
    final response = getContrastColor(backgroundColor);

    return Padding(
      padding: padding,
      child: TextButton(
        onPressed: () => onPressed(brand),
        style: TextButton.styleFrom(
          foregroundColor: splashEffect ? Colors.black : backgroundColor,
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          fixedSize: const Size(double.infinity, 53),
          shape: shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color: backgroundColor == Colors.white
                      ? const Color(0xFFAFBCC7)
                      : Colors.transparent,
                  width: 1.5,
                ),
              ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: 7, right: textCentering == Centering.relative ? 7 : 0),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: customImage != null && brand == Method.custom ||
                          customImage == null && brand != Method.custom
                      ? imageHeight
                      : 0,
                ),
                child: Center(
                  child: showLoader
                      ? SizedBox(
                          width: 21,
                          height: 21,
                          child: CircularProgressIndicator(
                            color: loaderColor == Colors.black
                                ? response == "dark"
                                    ? Colors.black
                                    : Colors.white
                                : loaderColor,
                          ))
                      : Text(
                          text.replaceFirst('{brand}', brand.name),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: fontSize, // 18 par defaut
                            color: textColor == Colors.black
                                ? response == "dark"
                                    ? Colors.black
                                    : Colors.white
                                : textColor,
                            fontWeight: fontWeight,
                            fontFamily: fontFamily,
                            letterSpacing: letterSpacing,
                          ),
                        ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: brand == Method.custom
                    ? (customImage != null
                        ? Image(
                            image: customImage!.image,
                            height: imageHeight,
                          )
                        : Container())
                    : Image.asset(
                        "packages/auth_button_kit/assets/logos${brand.isAdaptive ? "/$response" : ""}/${brand.name}.png",
                        height: imageHeight,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthMultiButtons extends StatelessWidget {
  /// A group of authentication buttons.
  const AuthMultiButtons({
    super.key,
    required this.onPressed,
    required this.brands,
    this.text = 'Continue with {brand}',
    this.textCentering = Centering.relative,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.shape,
    this.fontFamily,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 18,
    this.letterSpacing,
    this.showLoader,
    this.loaderColor = Colors.black,
    this.splashEffect = true,
    this.customImage,
    this.imageHeight = 21,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
  });

  /// The function called when the button is pressed, the brand (ex: Method.google) is passed as a parameter
  final Function(Method) onPressed;

  /// The list of brands
  final List<Method> brands;

  /// The text of the button, you can use {brand} to display the brand name
  final String text;

  /// The layout of the text for different visual choices
  final Centering textCentering;

  /// The text color of the button, adapts to contrast with background by default
  final Color textColor;

  /// The background color of the button
  final Color backgroundColor;

  /// The button's shape with options to specify borders (color, width) and corner radius
  final OutlinedBorder? shape;

  /// The font family of the button
  final String? fontFamily;

  /// The font weight of the button
  final FontWeight? fontWeight;

  /// The font size of the button text
  final double? fontSize;

  /// The letter spacing of the button text
  final double? letterSpacing;

  /// Show the loader of a specific button
  final Method? showLoader;

  /// The color of the loader, adapts to contrast with background by default
  final Color loaderColor;

  /// Show a splash effect when the button is pressed, does not work with a dark background
  final bool splashEffect;

  /// Change the default logo of the button, works only with AuthButton class and Method.custom
  final Image? customImage;

  /// The height of the image associated with the button
  final double imageHeight;

  /// Manage the space around the button
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var brand in brands)
          AuthButton(
            onPressed: (b) => onPressed(b),
            brand: brand,
            text: text,
            textCentering: textCentering,
            textColor: textColor,
            backgroundColor: backgroundColor,
            shape: shape,
            fontFamily: fontFamily,
            fontWeight: fontWeight,
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            showLoader: showLoader == brand,
            loaderColor: loaderColor,
            splashEffect: splashEffect,
            customImage: customImage,
            imageHeight: imageHeight,
            padding: padding,
          ),
      ],
    );
  }
}
