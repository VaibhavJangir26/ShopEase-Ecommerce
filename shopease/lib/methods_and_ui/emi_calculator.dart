import 'dart:math';

class EmiCalculator{

  static double emiCalculation(double principal){
    double rateOfInterest = 10.0; // default interest rate (10%)
    int timePeriod = 12; // default time period (12 months)
    double monthlyRate = rateOfInterest / (12 * 100);
    //formula: [P*r*(1+r)^n] / [(1+r)^n-1]
    double emi = (principal*monthlyRate*pow((1+monthlyRate), timePeriod)) / (pow((1 + monthlyRate),timePeriod) - 1);
    return emi;
  }

}