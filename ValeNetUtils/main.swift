//
//  main.swift
//  ValeNetUtils
//
//  Created by Валерия Пономарева on 27.05.2026.
//

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
case "pingchecker":
    runPingChecker()
case "upTime":
    runUpTime()
case "whoison":
    runWhoison()
case "filesize":
    runFilesize()
default:
    print("❌ Неизвестная команда: \(command)")
}
  
