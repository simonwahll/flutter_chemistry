import 'package:flutter/widgets.dart';
import 'package:chemistry/chemistry.dart';

/// This is a widget that takes an [Atom] and a function that returns a widget.
/// It is very similar to StreamBuilder, which is built in to Flutter.
class AtomBuilder<T> extends StatefulWidget {
  /// The function that is called with the value extracted from the [atom].
  /// It should return a widget and that widget will be the child of this
  /// [AtomBuilder].
  final Widget Function(BuildContext context, T value) builder;

  /// The [Atom] the value should be extracted from.
  final Atom atom;

  /// Constructor.
  /// [builder] the [builder] function.
  /// [atom] the [Atom] to use the value of.
  AtomBuilder({required this.builder, required this.atom, Key? key})
      : super(key: key);

  @override
  _AtomBuilderState<T> createState() => _AtomBuilderState<T>();
}

class _AtomBuilderState<T> extends State<AtomBuilder<T>> {
  /// The current value of the [atom].
  late T currentValue;

  /// Starts listening to [atom.stateStream] and sets [currentValue] when it
  /// changes.
  @override
  void initState() {
    widget.atom.stateStream.listen((newValue) {
      setState(() {
        currentValue = newValue;
      });
    });

    setState(() {
      currentValue = widget.atom.state;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, currentValue);
  }
}
