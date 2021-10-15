class CurrencyHelper {
  
  double convertTo(double amount, String? chosenCurrency) {
    if (chosenCurrency == "USD") {
      double converted = amount / 3.1;
      return converted;
    }

    if (chosenCurrency == "EUR") {
      double convertedEur = amount / 3.6;
      return convertedEur;
    }

    if (chosenCurrency == "GBP") {
      double convertedGbp = amount / 4.2;
      return convertedGbp;
    }

    return amount;
  }
}