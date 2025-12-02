import 'dart:io';
import 'package:colorful_text/colorful_text.dart' show ColorfulText;

void main() {
  const title = "===== Калькулятор индекса массы тела (ИМТ) =====";
  print(ColorfulText.paint(title, ColorfulText.yellow));

  // Пользуемся распаковкой значений.
  final (weight, height) = getInput();

  final double bmi = calcBMI(weight, height / 100);

  printBMI(bmi);
}

/// Рассчитывает ИМТ на основе веса и роста.
///
/// `weight` - вес в килограммах
/// `height` - рост в метрах
double calcBMI(double weight, double height) => weight / (height * height);

/// Получает данные о весе и росте от пользователя.
(double, double) getInput() {
  double weight = inputDoubleNumber('Введите ваш вес в килограммах: ');
  if (weight <= 0) {
    print("Вес должен быть положительным числом.");
    exit(1);
  }

  // Обратите внимание! Мы будем получать вес пользователя в сантиметрах.
  double height = inputDoubleNumber('Введите ваш рост в сантиметрах: ');
  if (height <= 0) {
    print('Рост должен быть положительными числом.');
    exit(1);
  }
  return (weight, height);
}

// Читает число с клавиатуры
double inputDoubleNumber(String prompt) {
  while (true) {
    stdout.write(prompt);
    String input = stdin.readLineSync()!;

    input = input.trim();

    if (input.isEmpty) {
      print('Пожалуйста, введите значение.');
      continue;
    }

    try {
      double value = double.parse(input);
      return value;
    } catch (e) {
      print('Некорректный ввод. Пожалуйста, введите число.');
    }
  }
}

/// Печатает ИМТ и его интерпретацию.
void printBMI(double bmi) {
  print('Ваш ИМТ: ${bmi.toStringAsFixed(2)}');
  if (bmi < 16) {
    print(
      ColorfulText.paint(
        'У Вас выраженный дефицит массы тела',
        ColorfulText.red,
      ),
    );
  } else if (bmi < 18.5) {
    print('У Вас недостаточная масса тела');
  } else if (bmi < 25) {
    print(
      ColorfulText.paint('У Вас нормальная масса тела', ColorfulText.green),
    );
  } else if (bmi < 30) {
    print('У Вас избыточная масса тела');
  } else if (bmi < 35) {
    print(ColorfulText.paint('У Вас ожирение I степени', ColorfulText.red));
  } else if (bmi < 40) {
    print(ColorfulText.paint('У Вас ожирение II степени', ColorfulText.red));
  } else {
    print(ColorfulText.paint('У Вас ожирение III степени', ColorfulText.red));
  }
}
