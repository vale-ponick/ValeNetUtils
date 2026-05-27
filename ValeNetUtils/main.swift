//
//  main.swift
//  ValeNetUtils
//
//  Created by Валерия Пономарева on 27.05.2026.
//

import Foundation
import Foundation

let arguments = CommandLine.arguments

guard arguments.count > 1 else {
    print("❌ Укажите утилиту: diskfree, processlist, pingchecker")
    exit(1)
}

let command = arguments[1]

switch command {
case "diskfree":
    runDiskFree()
case "processlist":
    runProcessList()
default:
    print("❌ Неизвестная команда: \(command)")
}
  
