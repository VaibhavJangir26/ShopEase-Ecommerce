import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shopease/methods_and_ui/toast_message.dart';

class CountdownTimerForDeal extends StatefulWidget {
  const CountdownTimerForDeal({super.key});

  @override
  State<CountdownTimerForDeal> createState() => CountdownTimerForDealState();
}

class CountdownTimerForDealState extends State<CountdownTimerForDeal> {
  // Countdown timer start duration
  Duration countdownDuration = const Duration(hours: 23, minutes: 59, seconds: 60);
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startCountdownTimer(); // Start the timer on initialization
  }

  // Start the countdown timer
  void startCountdownTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        // Decrement the duration
        final seconds = countdownDuration.inSeconds - 1;
        if (seconds < 0) {
          timer?.cancel();
          // Show a toast message when the countdown ends
          ToastMessage().showToastMsg("The sale has ended! Stay tuned for more deals.");
          countdownDuration = const Duration(hours: 23, minutes: 59, seconds: 60); // Restart the timer
          startCountdownTimer(); // Restart the timer
        } else {
          countdownDuration = Duration(seconds: seconds);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width*.95,
      height: height*.11,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.blue.shade300,
        borderRadius: BorderRadius.circular(15),
      ),
      child: countdownTimerUI(), // call the timer UI
    );
  }

  // countdown timer ui and working
  Widget countdownTimerUI() {
    String twoDigits(int n) => n.toString().padLeft(2, '0'); // Ensure two digits for hours, minutes, seconds
    final hours = twoDigits(countdownDuration.inHours);
    final minutes = twoDigits(countdownDuration.inMinutes.remainder(60));
    final seconds = twoDigits(countdownDuration.inSeconds.remainder(60));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Deal of the Day",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              Container(
                width: MediaQuery.of(context).size.width*.28,
                height: MediaQuery.of(context).size.width*.09,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white)
                ),
                child: const Row(
                  children: [
                    Text("View all",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                    Icon(Icons.arrow_forward_outlined,color: Colors.white,)
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.alarm,color: Colors.white),
              const SizedBox(width: 3,),
              buildTimeColumn(hours, "h"),
              buildTimeSeparator(),
              buildTimeColumn(minutes, "m"),
              buildTimeSeparator(),
              buildTimeColumn(seconds, "s"),
              const SizedBox(width: 5,),
              const Text("remaining",style: TextStyle(color: Colors.pink),),
            ],
          ),
        ],
      ),
    );
  }

  // to display the time
  Widget buildTimeColumn(String digit, String label) {
    return Row(
      children: [
        Text(digit,style: const TextStyle(fontWeight: FontWeight.w300,color: Colors.white)),
        Text(label,style: const TextStyle(fontWeight: FontWeight.w300,color: Colors.white)),

      ],
    );
  }

  // separate out by : bw time
  Widget buildTimeSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Text(":",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
    );
  }
}
