import Foundation

guard CommandLine.arguments.count == 3,
      let firstNumber = Double(CommandLine.arguments[1]),
      let secondNumber = Double(CommandLine.arguments[2]) else {
    fputs("Usage: swift Sum.swift <number1> <number2>\n", stderr)
    exit(EXIT_FAILURE)
}

print(firstNumber + secondNumber)
