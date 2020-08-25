extension ListUtils on List {
  List<T> distinct<T>() => (this.toSet() as Set<T>).toList();
}
