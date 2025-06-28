import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/src/models/country_model.dart';
import 'package:intl_phone_number_input/src/utils/selector_config.dart';
import 'package:intl_phone_number_input/src/utils/test/test_helper.dart';
import 'package:intl_phone_number_input/src/widgets/countries_search_list_widget.dart';
import 'package:intl_phone_number_input/src/widgets/input_widget.dart';
import 'package:intl_phone_number_input/src/widgets/item.dart';
import 'package:intl_phone_number_input/src/utils/bottom_sheet_config.dart';
import 'package:intl_phone_number_input/src/utils/util.dart';

/// [SelectorButton]
class SelectorButton extends StatelessWidget {
  final List<Country> countries;
  final Country? country;
  final SelectorConfig selectorConfig;
  final TextStyle? selectorTextStyle;
  final InputDecoration? searchBoxDecoration;
  final bool autoFocusSearchField;
  final String? locale;
  final bool isEnabled;
  final bool isScrollControlled;

  final ValueChanged<Country?> onCountryChanged;

  const SelectorButton({
    Key? key,
    required this.countries,
    required this.country,
    required this.selectorConfig,
    required this.selectorTextStyle,
    required this.searchBoxDecoration,
    required this.autoFocusSearchField,
    required this.locale,
    required this.onCountryChanged,
    required this.isEnabled,
    required this.isScrollControlled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return selectorConfig.selectorType == PhoneInputSelectorType.DROPDOWN
        ? countries.isNotEmpty && countries.length > 1
            ? DropdownButtonHideUnderline(
                child: DropdownButton<Country>(
                  key: Key(TestHelper.DropdownButtonKeyValue),
                  hint: Item(
                    country: country,
                    showFlag: selectorConfig.showFlags,
                    useEmoji: selectorConfig.useEmoji,
                    leadingPadding: selectorConfig.leadingPadding,
                    trailingSpace: selectorConfig.trailingSpace,
                    textStyle: selectorTextStyle,
                  ),
                  value: country,
                  items: mapCountryToDropdownItem(countries),
                  onChanged: isEnabled ? onCountryChanged : null,
                ),
              )
            : Item(
                country: country,
                showFlag: selectorConfig.showFlags,
                useEmoji: selectorConfig.useEmoji,
                leadingPadding: selectorConfig.leadingPadding,
                trailingSpace: selectorConfig.trailingSpace,
                textStyle: selectorTextStyle,
              )
        : MaterialButton(
            key: Key(TestHelper.DropdownButtonKeyValue),
            padding: EdgeInsets.zero,
            minWidth: 0,
            onPressed: countries.isNotEmpty && countries.length > 1 && isEnabled
                ? () async {
                    Country? selected;
                    if (selectorConfig.selectorType ==
                        PhoneInputSelectorType.CUSTOM_BOTTOM_SHEET) {
                      selected = await showConfigurableBottomSheet(
                        context,
                        countries,
                        selectorConfig.bottomSheetConfig!,
                      );
                    } else if (selectorConfig.selectorType ==
                        PhoneInputSelectorType.BOTTOM_SHEET) {
                      selected = await showCountrySelectorBottomSheet(
                        context,
                        countries,
                      );
                    } else {
                      selected =
                          await showCountrySelectorDialog(context, countries);
                    }

                    if (selected != null) {
                      onCountryChanged(selected);
                    }
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Item(
                country: country,
                showFlag: selectorConfig.showFlags,
                useEmoji: selectorConfig.useEmoji,
                leadingPadding: selectorConfig.leadingPadding,
                trailingSpace: selectorConfig.trailingSpace,
                textStyle: selectorTextStyle,
              ),
            ),
          );
  }

  /// Converts the list [countries] to `DropdownMenuItem`
  List<DropdownMenuItem<Country>> mapCountryToDropdownItem(
    List<Country> countries,
  ) {
    return countries.map((country) {
      return DropdownMenuItem<Country>(
        value: country,
        child: Item(
          key: Key(TestHelper.countryItemKeyValue(country.alpha2Code)),
          country: country,
          showFlag: selectorConfig.showFlags,
          useEmoji: selectorConfig.useEmoji,
          textStyle: selectorTextStyle,
          withCountryNames: false,
          trailingSpace: selectorConfig.trailingSpace,
        ),
      );
    }).toList();
  }

  /// shows a Dialog with list [countries] if the [PhoneInputSelectorType.DIALOG] is selected
  Future<Country?> showCountrySelectorDialog(
    BuildContext inheritedContext,
    List<Country> countries,
  ) {
    return showDialog(
      context: inheritedContext,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        content: Directionality(
          textDirection: Directionality.of(inheritedContext),
          child: Container(
            width: double.maxFinite,
            child: CountrySearchListWidget(
              countries,
              locale,
              searchBoxDecoration: searchBoxDecoration,
              showFlags: selectorConfig.showFlags,
              useEmoji: selectorConfig.useEmoji,
              autoFocus: autoFocusSearchField,
            ),
          ),
        ),
      ),
    );
  }

  /// shows a Dialog with list [countries] if the [PhoneInputSelectorType.BOTTOM_SHEET] is selected
  Future<Country?> showCountrySelectorBottomSheet(
    BuildContext inheritedContext,
    List<Country> countries,
  ) {
    return showModalBottomSheet(
      context: inheritedContext,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      useSafeArea: selectorConfig.useBottomSheetSafeArea,
      builder: (BuildContext context) {
        return Stack(children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: DraggableScrollableSheet(
              builder: (BuildContext context, ScrollController controller) {
                return Directionality(
                  textDirection: Directionality.of(inheritedContext),
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Theme.of(context).canvasColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    child: CountrySearchListWidget(
                      countries,
                      locale,
                      searchBoxDecoration: searchBoxDecoration,
                      scrollController: controller,
                      showFlags: selectorConfig.showFlags,
                      useEmoji: selectorConfig.useEmoji,
                      autoFocus: autoFocusSearchField,
                    ),
                  ),
                );
              },
            ),
          ),
        ]);
      },
    );
  }

  /// Shows a configurable bottom sheet using BottomSheetConfig
  Future<Country?> showConfigurableBottomSheet(
    BuildContext inheritedContext,
    List<Country> countries,
    BottomSheetConfig config,
  ) {
    List<Country> filteredCountries = List.from(countries);

    return showModalBottomSheet<Country>(
      context: inheritedContext,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      useSafeArea: selectorConfig.useBottomSheetSafeArea,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * config.height,
              decoration: BoxDecoration(
                color: config.backgroundColor ?? Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(config.borderRadius),
                  topRight: Radius.circular(config.borderRadius),
                ),
              ),
              child: Column(
                children: [
                  // Custom header or default header
                  if (config.customHeader != null) config.customHeader!,

                  // Search field
                  if (config.showSearchField) ...[
                    _buildSearchField(context, config, (value) {
                      setState(() {
                        filteredCountries = Utils.filterCountries(
                          countries: countries,
                          locale: locale,
                          value: value,
                        );
                      });
                    }),
                    SizedBox(height: 16),
                  ],
                  // Countries list
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Divider(
                          color: config.strokeColor ?? Colors.grey[300]!,
                          height: 0.5,
                        ),
                      ),
                      itemCount: filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = filteredCountries[index];

                        if (config.customItemBuilder != null) {
                          return GestureDetector(
                            onTap: () => Navigator.pop(context, country),
                            child: config.customItemBuilder!(
                              context,
                              country,
                              false,
                            ),
                          );
                        }

                        return _buildDefaultCountryItem(
                          context,
                          country,
                          config,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSearchField(
    BuildContext context,
    BottomSheetConfig config,
    ValueChanged<String> onChanged,
  ) {
    return Container(
      height: config.searchFieldHeight ?? 48,
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        decoration: config.searchFieldDecoration ??
            InputDecoration(
              hintText: config.searchHintText ?? 'Search...',
              hintStyle: config.hintStyle ??
                  TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
              prefixIcon: Icon(
                Icons.search,
                color: config.prefixIconColor ?? Colors.grey[600],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: config.strokeColor ?? Colors.grey[300]!,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: config.strokeColor ?? Colors.grey[300]!,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: config.selectedColor ?? Theme.of(context).primaryColor,
                  width: 1,
                ),
              ),
              filled: true,
              fillColor: config.searchFieldColor ?? Colors.grey[100],
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: config.searchFieldHeight != null
                    ? (config.searchFieldHeight! - 20) / 2
                    : 12,
              ),
            ),
        style: config.textStyle ??
            TextStyle(
              fontSize: 16,
              color: config.primaryTextColor ??
                  Theme.of(context).textTheme.bodyLarge?.color,
            ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDefaultCountryItem(
    BuildContext context,
    Country country,
    BottomSheetConfig config,
  ) {
    return InkWell(
      onTap: () => Navigator.pop(context, country),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Flag
            if (config.showFlags)
              Container(
                width: 32,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: config.strokeColor ?? Colors.grey[300]!,
                    width: 0.5,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: config.useEmojiFlags
                      ? Center(
                          child: Text(
                            Utils.generateFlagEmojiUnicode(
                              country.alpha2Code ?? '',
                            ),
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      : Image.asset(
                          country.flagUri,
                          package: 'intl_phone_number_input',
                          width: 32,
                          height: 24,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[100],
                              child: Center(
                                child: Text(
                                  Utils.generateFlagEmojiUnicode(
                                    country.alpha2Code ?? '',
                                  ),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),

            if (config.showFlags) SizedBox(width: 16),

            // Country name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  country.name ?? '',
                  style: config.countryNameTextStyle ??
                      TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: config.primaryTextColor ??
                            Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                ),
                SizedBox(height: 4),
                Text(
                  country.dialCode ?? '',
                  style: config.countryCodeTextStyle ??
                      TextStyle(
                        fontSize: 12,
                        color: config.secondaryTextColor ?? Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
