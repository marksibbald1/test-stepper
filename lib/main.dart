import 'package:flutter/material.dart';

/// Flutter code sample for [Stepper].

void main() => runApp(const StepperExampleApp());

class StepperExampleApp extends StatelessWidget {
  const StepperExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Stepper Sample')),
        body: const Center(
          child: StepperExample(),
        ),
      ),
    );
  }
}

class StepperExample extends StatefulWidget {
  const StepperExample({Key? key}) : super(key: key);

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  int _index = 0;

  final List<Step> steps = [
    Step(
      label: Text("Checking sequencing data"),
      title: SizedBox.shrink(),
      content: Text("Content for Step 1"),
      state: StepState.editing,
    ),
    Step(
      label: Text("Sequencing data OK"),
      title: SizedBox.shrink(),
      content: Text("Test"),
      state: StepState.complete,
    ),
    Step(
      label: Text("Analysing sequencing data"),
      title: SizedBox.shrink(),
      content: Text("Content for Step 3"),
      state: StepState.editing,
    ),
    Step(
      label: Text("Download recommendations treatment report"),
      title: SizedBox.shrink(),
      content: Text("Content for Step 4"),
      state: StepState.complete,
    ),
  ];

  Widget customIconBuilder(int index, StepState stepState) {
    final label = steps[index].label as Text;

    switch (label.data) {
      case "Checking sequencing data":
        return const Icon(Icons.science_outlined);
      case "Download recommendations treatment report":
        return const Icon(Icons.task_outlined);
      case "Analysing sequencing data":
        return const Icon(Icons.query_stats_outlined);
      case "Sequencing data OK":
        return const Icon(Icons.thumb_up_alt_outlined);
      default:
        return const Icon(Icons.question_mark_outlined);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      stepIconBuilder: customIconBuilder,
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: steps,
    );
  }
}
