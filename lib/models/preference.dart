import 'package:money_monitor/models/category.dart';

class Preferences {
  String theme;
  String currency;
  String monthlyTarget;
  String yearlyTarget;
  List<Category> categories;

  Preferences(this.theme, this.currency, this.categories, this.monthlyTarget, this.yearlyTarget);

  set updateCategories(List<Category> newCategories) {
    categories = newCategories;
  }

  set updateTheme(String newTheme) {
    theme = newTheme;
  }

  set updateCurrency(String newCurrency) {
    currency = newCurrency;
  }

  set updateMonthlyTarget(String newMontlyTarget) {
    monthlyTarget = newMontlyTarget;
  }

  set updateYearlyTarget(String newYearlyTarget) {
    yearlyTarget = newYearlyTarget;
  }


}
