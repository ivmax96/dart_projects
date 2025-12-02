import 'dart:io';
import 'dart:math' show Random; // Для генерации случайных чисел.

/// Генерирует случайные целые числа в диапазоне [`min`, `max`]
int randomInt(int min, int max) {
  final random = Random(); // Создаём генератор случайных чисел.
  return min + random.nextInt(max - min + 1);
}

int readUserNumber(int attempts, int min, int max) {
  while (true) {
    stdout.write('Попытка $attempts. Введите ваше число: ');
    String input = stdin.readLineSync()!;
    input = input.trim(); // Убираем пробелы на концах ввода.

    if (input.isEmpty) {
      print('Вы ничего не ввели. Попробуйте снова.');
      continue;
    }

    // tryParse возвращает null, если не получилось преобразовать строку в число.
    final userNumber = int.tryParse(input);
    if (userNumber == null) {
      print('Введено некорректное значение. Пожалуйста, введите целое число.');
      continue;
    }

    if (userNumber < min || userNumber > max) {
      print('Ваше число должно быть в диапазоне от $min до $max включительно.');
      continue;
    }

    return userNumber;
  }
}

void main() {
  print('===== Игра "Угадай число" =====');

  // Задаём диапазон
  const min = 1;
  const max = 100;

  final secretNumber = randomInt(min, max);

  // Для красоты.
  print('Загадано число от $min до $max включительно. Попробуйте угадать его.');
  print("Постарайтесь потратить как можно меньше попыток.");

  // Для подсчёта числа попыток.
  int attempts = 0;

  while (true) {
    attempts++;

    final userNumber = readUserNumber(attempts, min, max);

    if (userNumber == secretNumber) {
      print("Вы угадали число $secretNumber с $attempts попытки.");
      break;
    } else if (userNumber < secretNumber) {
      print('Загаданное число больше.');
    } else {
      print('Загаданное число меньше.');
    }
  }
}
