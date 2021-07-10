# Flutter Chemistry

You should also take a look at the chemistry package.

## About

Chemistry is a state management library highly inspired by Recoil for React. It aims to be easy to use and integrate well with the Flutter platform.

Chemistry separates pure state from derived state. Pure state is called Atoms and derived state is called Molecules. A store, called Chemistry, is provided where all atoms and molecules can be stored and accessed anywhere in the program. This allows state to be accessed and modified in any widget without passing any state as parameters between them.

See the example for an example.

## Usage

### AtomBuilder

AtomBuilders are similar to StreamBuilders. It is a widget that is called with an atom and a function that receives the value of the atom as a parameter and is expected to return a widget. The widget returned is the child of the AtomBuilder. The widget automatically rebuilds and the builder function will be called with the new value when the state of the atom changes.

Example:

```dart
// Somewhere before the build method.
var myAtom = Atom<String>(defaultValue: 'Hello', key: 'myAtom');

// In the build method.
AtomBuilder<String>(
    atom: myAtom,
    builder: (context, value) => Text(value),)
```

### MoleculeBuilder

These work just like AtomBuilder but for molecules.

Example:
```dart
// Somewhere before the build method.
var myMolecule = Molecule<int>(
    atoms: [firstAtom, secondAtom],
    computer: (getAtom) =>
        getAtom<int>('firstAtom')!.state + getAtom<int>('secondAtom')!.state,
    key: 'myMolecule');

// In the build method.
AtomBuilder<int>(
    molecule: myMolecule,
    builder: (context, value) => Text(value.toString()),)
```
