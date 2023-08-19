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

  Widget customIconBuilder(int index, StepState stepState) {
    print(index);
    switch (index) {
      case 0:
        return const Icon(Icons.lock);
      default:
        return const Icon(Icons.error);
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
      steps: <Step>[
        Step(
          label: Text("Step 1 title"),
          title: SizedBox.shrink(),
          content: Container(
            alignment: Alignment.centerLeft,
            child: Text("Content for Step 1"),
          ),
          state: StepState.editing,
        ),
        Step(
          label: Text("Step 2 title"),
          title: SizedBox.shrink(),
          content: Container(
            alignment: Alignment.centerLeft,
            child: Text("Content for Step 2"),
          ),
          state: StepState.complete,
        ),
      ],
    );
  }
}
