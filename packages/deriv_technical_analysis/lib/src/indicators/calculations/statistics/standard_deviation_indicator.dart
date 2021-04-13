import 'dart:math';

import 'package:deriv_technical_analysis/src/models/models.dart';

import '../../cached_indicator.dart';
import '../../indicator.dart';
import 'variance_indicator.dart';

/// Standard deviation indicator.
class StandardDeviationIndicator<T extends IndicatorResult>
    extends CachedIndicator<T> {
  /// Initializes
  ///
  /// [indicator] the indicator to calculates SD on.
  /// [period]  the time frame
  StandardDeviationIndicator(Indicator<T> indicator, int period)
      : _variance = VarianceIndicator<T>(indicator, period),
        super.fromIndicator(indicator);

  final VarianceIndicator<T> _variance;

  @override
  T calculate(int index) => createResult(
        index: index,
        quote: sqrt(_variance.getValue(index).quote),
      );

  @override
  void copyValuesFrom(covariant StandardDeviationIndicator<T> other) {
    super.copyValuesFrom(other);
    _variance.copyValuesFrom(other._variance);
  }

  @override
  void invalidate(int index) {
    super.invalidate(index);
    _variance.invalidate(index);
  }

  @override
  T refreshValueFor(int index) {
    invalidate(index);
    _variance.getValue(index);
    return getValue(index);
  }
}
