import 'package:flutter/material.dart';

/// [BottomSheetConfig] contains configuration for custom bottom sheet styling
class BottomSheetConfig {
  /// Background color of the bottom sheet
  final Color? backgroundColor;

  /// Primary text color (titles, country names)
  final Color? primaryTextColor;

  /// Secondary text color (hints, subtitles)
  final Color? secondaryTextColor;

  /// Height of the search field
  final double? searchFieldHeight;

  /// Prefix icon color
  final Color? prefixIconColor;

  /// Border/stroke color
  final Color? strokeColor;

  /// Divider color
  final Color? dividerColor;

  /// Selected item highlight color
  final Color? selectedColor;

  /// Search field background color
  final Color? searchFieldColor;

  /// Border radius for the bottom sheet
  final double borderRadius;

  /// Header title text
  final String? headerTitle;

  /// Header subtitle text
  final String? headerSubtitle;

  /// Header subtitle text style
  final TextStyle? headerSubtitleTextStyle;

  /// Search field hint text
  final String? searchHintText;

  /// Header text style
  final TextStyle? headerTextStyle;

  /// Country name text style
  final TextStyle? countryNameTextStyle;

  /// Country code text style
  final TextStyle? countryCodeTextStyle;

  /// Search field text style
  final TextStyle? hintStyle;

  /// Search field decoration
  final InputDecoration? searchFieldDecoration;

  /// Show search field
  final bool showSearchField;

  /// Height of the bottom sheet (0.0 - 1.0)
  final double height;

  /// Show country flags
  final bool showFlags;

  /// Use emoji flags instead of images
  final bool useEmojiFlags;

  /// Custom header widget
  final Widget? customHeader;

  /// Custom item builder
  final Widget Function(BuildContext context, dynamic country, bool isSelected)?
      customItemBuilder;

  const BottomSheetConfig({
    this.backgroundColor,
    this.primaryTextColor,
    this.secondaryTextColor,
    this.searchFieldHeight,
    this.strokeColor,
    this.selectedColor,
    this.searchFieldColor,
    this.borderRadius = 20.0,
    this.headerTitle,
    this.searchHintText,
    this.headerTextStyle,
    this.countryNameTextStyle,
    this.countryCodeTextStyle,
    this.hintStyle,
    this.searchFieldDecoration,
    this.showSearchField = true,
    this.height = 0.8,
    this.showFlags = true,
    this.useEmojiFlags = false,
    this.customHeader,
    this.customItemBuilder,
    this.headerSubtitle,
    this.headerSubtitleTextStyle,
    this.dividerColor,
    this.prefixIconColor,
  });

  /// Creates a copy of this config with the given fields replaced with new values
  BottomSheetConfig copyWith({
    Color? backgroundColor,
    Color? primaryTextColor,
    Color? secondaryTextColor,
    double? searchFieldHeight,
    Color? strokeColor,
    Color? selectedColor,
    Color? searchFieldColor,
    double? borderRadius,
    String? headerTitle,
    String? searchHintText,
    TextStyle? headerTextStyle,
    TextStyle? countryNameTextStyle,
    TextStyle? countryCodeTextStyle,
    TextStyle? hintStyle,
    InputDecoration? searchFieldDecoration,
    bool? showSearchField,
    double? height,
    bool? showFlags,
    bool? useEmojiFlags,
    TextStyle? headerSubtitleTextStyle,
    Widget? customHeader,
    Color? dividerColor,
    Color? prefixIconColor,
    Widget Function(BuildContext context, dynamic country, bool isSelected)?
        customItemBuilder,
  }) {
    return BottomSheetConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      searchFieldHeight: searchFieldHeight ?? this.searchFieldHeight,
      strokeColor: strokeColor ?? this.strokeColor,
      selectedColor: selectedColor ?? this.selectedColor,
      searchFieldColor: searchFieldColor ?? this.searchFieldColor,
      borderRadius: borderRadius ?? this.borderRadius,
      headerTitle: headerTitle ?? this.headerTitle,
      searchHintText: searchHintText ?? this.searchHintText,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      countryNameTextStyle: countryNameTextStyle ?? this.countryNameTextStyle,
      countryCodeTextStyle: countryCodeTextStyle ?? this.countryCodeTextStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      searchFieldDecoration:
          searchFieldDecoration ?? this.searchFieldDecoration,
      showSearchField: showSearchField ?? this.showSearchField,
      height: height ?? this.height,
      showFlags: showFlags ?? this.showFlags,
      useEmojiFlags: useEmojiFlags ?? this.useEmojiFlags,
      customHeader: customHeader ?? this.customHeader,
      customItemBuilder: customItemBuilder ?? this.customItemBuilder,
      headerSubtitle: headerSubtitle ?? this.headerSubtitle,
      headerSubtitleTextStyle:
          headerSubtitleTextStyle ?? this.headerSubtitleTextStyle,
      dividerColor: dividerColor ?? this.dividerColor,
      prefixIconColor: prefixIconColor ?? this.prefixIconColor,
    );
  }
}
