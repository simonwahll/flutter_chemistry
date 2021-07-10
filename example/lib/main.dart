import 'package:flutter/material.dart';
import 'package:chemistry/chemistry.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Chemistry chemistry = Chemistry();
  late Atom<double> firstNumber;
  late Atom<double> secondNumber;
  late Atom<String> selectedOperator;
  late Molecule<dynamic> sum;

  @override
  void initState() {
    firstNumber = Atom<double>(defaultValue: 0, key: 'firstNumber');
    secondNumber = Atom<double>(defaultValue: 0, key: 'secondNumber');
    selectedOperator = Atom<String>(defaultValue: '+', key: 'selectedOperator');

    chemistry.addAtom(firstNumber);
    chemistry.addAtom(secondNumber);
    chemistry.addAtom(selectedOperator);

    sum = Molecule<dynamic>(
        atoms: [firstNumber, secondNumber, selectedOperator],
        computer: (getAtom) {
          switch (getAtom<String>('selectedOperator')!.state) {
            case '+':
              return getAtom<double>('firstNumber')!.state +
                  getAtom<double>('secondNumber')!.state;
            case '-':
              return getAtom<double>('firstNumber')!.state -
                  getAtom<double>('secondNumber')!.state;
            case '*':
              return getAtom<double>('firstNumber')!.state *
                  getAtom<double>('secondNumber')!.state;
            case '/':
              return getAtom<double>('firstNumber')!.state /
                  getAtom<double>('secondNumber')!.state;
          }

          return 'Error';
        },
        key: 'sum');

    chemistry.addMolecule(sum);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) =>
                            firstNumber.setState(double.parse(value)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'First number',
                        ),
                      ),
                    ),
                    Expanded(
                      child: AtomBuilder<String>(
                        builder: (context, value) => DropdownButton<String>(
                          value: value,
                          items: [
                            DropdownMenuItem(
                              child: Text('+'),
                              value: '+',
                            ),
                            DropdownMenuItem(
                              child: Text('-'),
                              value: '-',
                            ),
                            DropdownMenuItem(
                              child: Text('*'),
                              value: '*',
                            ),
                            DropdownMenuItem(
                              child: Text('/'),
                              value: '/',
                            ),
                          ],
                          onChanged: (value) =>
                              selectedOperator.setState(value!),
                        ),
                        atom: selectedOperator,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) =>
                            secondNumber.setState(double.parse(value)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Second number',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: MoleculeBuilder<double>(
                    builder: (context, value) => Text('= $value'),
                    molecule: sum),
              )
            ],
          ),
        ),
      ),
    );
  }
}
