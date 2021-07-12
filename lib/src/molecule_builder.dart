import 'package:flutter/widgets.dart';
import 'package:chemistry/chemistry.dart';

/// This is a widget that takes a [Molecule] and a function that returns a
/// widget. It is very similar to StreamBuilder, which is built in to Flutter.
class MoleculeBuilder<T> extends StatefulWidget {
  /// The function that is called with the value extracted from the [molecule].
  /// It should return a widget and that widget will be the child of this
  /// [MoleculeBuilder].
  final Widget Function(BuildContext context, T value) builder;

  /// The [Molecule] the value should be extracted from.
  final Molecule molecule;

  /// Constructor.
  /// [builder] the [builder] function.
  /// [molecule] the [Molecule] to use the value of.
  MoleculeBuilder({required this.builder, required this.molecule, Key? key})
      : super(key: key);

  @override
  _MoleculeBuilderState<T> createState() => _MoleculeBuilderState<T>();
}

class _MoleculeBuilderState<T> extends State<MoleculeBuilder<T>> {
  /// The current value of the [molecule].
  late T currentValue;

  /// Starts listening to [molecule.stateStream] and sets [currentValue] when it
  /// changes.
  @override
  void initState() {
    widget.molecule.stateStream.listen((newValue) {
      setState(() {
        currentValue = newValue;
      });
    });

    setState(() {
      currentValue = widget.molecule.state;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, currentValue);
  }
}
