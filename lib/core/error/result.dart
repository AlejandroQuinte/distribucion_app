class Either<L, R> {
  final L? _left;
  final R? _right;

  Either._(this._left, this._right);

  // Constructor to left (error)
  factory Either.left(L left) => Either._(left, null);

  // Constructor to right (success)
  factory Either.right(R right) => Either._(null, right);

  bool isLeft() => _left != null;
  bool isRight() => _right != null;

  L get left => _left!;
  R get right => _right!;

  T fold<T>(T Function(L) onLeft, T Function(R) onRight) {
    if (isLeft()) {
      return onLeft(left);
    } else {
      return onRight(right);
    }
  }
}
