
/// extracted from https://github.com/renanborgez/kandinsky-dart which is Dart
/// port of https://github.com/francisrstokes/kandinsky-js but is no longer
/// maintained and not null safe
class Kandinsky {

  /// returns a length `n` array of Vector3 colours. colours are the ones
  /// formed from the `linearGradient(n/(numColours-1), color1, color2)`
  /// for all colours `color1, color2, ..., colorN`
  static List<List<num>> multiGradient(num n, List<List<num>> colors) {
    var i = -1;
    return colors.fold([], (grad, color) {
      i = i + 1;
      if (i == 0) {
        return grad;
      }
      var color1 = colors[i - 1];
      var color2 = color;

      int values = (n / (colors.length - 1)).round();
      if (i == colors.length - 1 || i == 1) {
        values = (n / (colors.length - 1)).ceil();
      }

      return [...grad, ...linearGradient(values, color1, color2)];
    });
  }

  /// returns an length `n` array of Vector3 colours. colours are
  /// evenly spaced between `color1` and `color2`.
  static List<List<num>> linearGradient(
      int n,
      List<num> color1,
      List<num> color2,
      ) {
    var d = (n - 1 != 0) ? n - 1 : 1;
    var result = List.generate(n, (i) => lerp3(i / d, color1, color2)).toList();
    return result;
  }

  /// returns a Vector3 colour somewhere between `c1` and `c2`.
  /// `t` is the "time" value in the range `[0, 1]`
  static List<num> lerp3(num t, List<num> color1, List<num> color2) {
    var r1 = color1[0];
    var g1 = color1[1];
    var b1 = color1[2];

    var r2 = color2[0];
    var g2 = color2[1];
    var b2 = color2[2];

    return [
      r1 + (t * (r2 - r1)),
      g1 + (t * (g2 - g1)),
      b1 + (t * (b2 - b1)),
    ].toList();
  }

}