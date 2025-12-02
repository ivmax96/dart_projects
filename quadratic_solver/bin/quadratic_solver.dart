import 'dart:math' show sqrt;
import 'dart:io';

void main() {
  print('===== Калькулятор квадратных уравнений =====\n');

  double a = readDouble('Введите коэффициент a: ');
  if (a == 0) {
    print(
      'Ошибка: коэффициент "a" в квадратном уравнении не может быть равен нулю.',
    );
    exit(1); // Выходим из программы, так как это не квадратное уравнение.
  }
  double b = readDouble('Введите коэффициент b: ');
  double c = readDouble('Введите коэффициент c: ');

  print("Вы ввели уравнение: ${formatEquation(a, b, c)}");

  final d = calcDiscriminant(a, b, c);
  print('\nДискриминант D = ${formatDouble(d)}');

  if (d > 0) {
    double sqrtD = sqrt(d);
    double x1 = (-b + sqrtD) / (2 * a);
    double x2 = (-b - sqrtD) / (2 * a);
    print('Уравнение имеет два корня:');
    print('x1 = ${formatDouble(x1)}');
    print('x2 = ${formatDouble(x2)}');
  } else if (d == 0) {
    double x = -b / (2 * a);
    print('Уравнение имеет два совпадающих корня:');
    print('x = ${formatDouble(x)}');
  } else {
    print("Действительных корней нет.");
  }
}

/// Вычисляет дискриминант
double calcDiscriminant(double a, b, c) => b * b - 4 * a * c;

/// Читает вещественное число с клавиатуры
double readDouble(String prompt) {
  while (true) {
    stdout.write(prompt);
    String input = stdin.readLineSync()!;
    input = input.trim();

    if (input.isEmpty) {
      print("Вы ничего не ввели. Пожалуйста, введите число.");
      continue;
    }

    try {
      return double.parse(input);
    } catch (e) {
      print('Некорректный ввод. Пожалуйста, введите число.');
    }
  }
}

/// Форматирует дробные числа для более красивого отображения.
///
/// `fractionDigits` - количество цифр в дробной части.
/// Если число не имеет дробной части, то оно будет выглядеть как целое.
String formatDouble(double value, {int fractionDigits = 3}) {
  if (value.toInt() == value) {
    return value.toInt().toString();
  } else {
    return value.toStringAsFixed(fractionDigits);
  }
}

/// Форматирует квадратное уравнение в красивом виде.
String formatEquation(double a, double b, double c) {
  List<String> parts = [];

  // Слагаемое с x²
  if (a == 1) {
    parts.add('x²');
  } else if (a == -1) {
    parts.add('-x²');
  } else {
    // Используем функцию formatDouble, которую мы написали ранее.
    parts.add('${formatDouble(a)}x²');
  }

  // Слагаемое с x
  if (b != 0) {
    parts.add(b > 0 ? '+' : '-');
    double absB = b.abs();
    if (absB == 1) {
      parts.add('x');
    } else {
      parts.add(formatDouble(absB) + "x");
    }
  }

  // Свободный член
  if (c != 0) {
    parts.add(c > 0 ? '+' : '-');
    parts.add(formatDouble(c.abs()));
  }

  return parts.join(' ') + " = 0";
}
